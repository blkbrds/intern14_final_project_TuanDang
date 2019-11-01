//
//  ContactsViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/28/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Detect action happening.
enum RealmAction {
    case update
    case addNew
    case delete
    case clearAll
    case reloadTable
}

// MARK: Method called when realm changing.
protocol ContactsViewModelDelegate: class {
    func realmChanging(listeningBy: ContactsViewModel, action: RealmAction)
}

class ContactsViewModel {

    var contacts: [[ContactDomain]] = [[]]
    var contactsIndex: [String] = []
    var notificationToken: NotificationToken?

    // MARK: 4. Mock action by Delegate.
    weak var delegate: ContactsViewModelDelegate?
    
    private var displayValue: [IndexPath]?

    var isNextPage = true
    var startPage = 0
    
    init() { }
    
    func numberOfSections() -> Int {
        return contacts.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return contacts[section].count
    }
    
    func getHeader(at: Int) -> String? {
        if contactsIndex.count > 0 {
            return contactsIndex[at]
        } else { return nil }
    }
    
    func getSectionIndex() -> [String]? {
        return self.contactsIndex
    }
    func getCellModel(at: IndexPath) -> ContactCellViewModel {
        return ContactCellViewModel(contact: contacts[at.section][at.row])
    }
    
    // MARK: 0. Fetch data from Realm and display to view.
    func fetchContactsToDisplay() {
        (contactsIndex, contacts) = createContactsIndex(contactsData: fetchRealmContacts())
    }
    
    
    // MARK: 1.Fetch contacts from Server and sync to Realm
    func getContacts(completion: @escaping APICompletion) {
        Api.Contacts.getContacts() {
            result in
            switch result {
            case .success(let contactsResult):
                let addedContacts = self.syncResponseDataWithRealm(data: contactsResult)

                // MARK: 2. Save new contacts to Realm.
                RealmManager.shared.add(objects: addedContacts)
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: 1.1.Fetch datas from Realm
    func fetchRealmContacts() -> [ContactDomain] {
        // MARK: Call to API fetch datas from Realm
        guard let realmContacts = RealmManager.shared.fetchObjects(ContactDomain.self) else {
            return []
        }
        return realmContacts.reversed()
        
    }
    
    // MARK: 1.2. Compare contacts between API and Realm => Get new contacts added.
    private func syncResponseDataWithRealm(data: [ContactDomain]) -> [ContactDomain] {
        var sameValue = false
        var addedObjects: [ContactDomain] = []
        let realmContacts = fetchRealmContacts()

        for domain in data {
            sameValue = false
            for contact in realmContacts {
                if domain.id.elementsEqual(contact.id) {
                    sameValue = true
                    break
                }
            }
            if (sameValue == false) {
                addedObjects.append(domain)
            }
        }
        return addedObjects
    }
    
    // MARK: 3. Create observe listening realm change.
    func listeningRealmChange() {
        notificationToken = RealmManager.shared.observe(type: ContactDomain.self, completion: { [weak self] changeColumn in
            
            // MARK: Fetch object listener and realm contacts
            guard let listening = self else { return }
            (listening.contactsIndex, listening.contacts) = listening.createContactsIndex(contactsData: listening.fetchRealmContacts())

            // MARK: Call back to view controller. => Reload data.
            listening.delegate?.realmChanging(listeningBy: listening, action: RealmAction.reloadTable)
        })
    }
    
    func downloadImage(with indexPath: IndexPath, completion: @escaping (IndexPath, UIImage?) -> Void) {
        
        let imageURL = contacts[indexPath.section][indexPath.row].imgUrl
        let urlRequest = URLRequest(url: URL(string: imageURL)!)
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if error != nil {
                print("Error content: \(error!)")
            }
            if let data = data {
                let image = UIImage(data: data)
                completion(indexPath, image)
            } else {
                completion(indexPath, nil)
            }
        }
    }
    
    // MARK: Create contacts header group and contact index.
    private func createContactsIndex(contactsData: [ContactDomain]) -> ([String], [[ContactDomain]]) {
        var tempData: [[ContactDomain]] = [[]]
        var tempIndex: [String] = []
        // Create index by prefix animal name.
        tempData.remove(at: 0)
        for contactName in contactsData {
            var foundPrefix = false
            for prefix in 0..<tempIndex.count {
                if contactName.username.prefix(1).elementsEqual(tempIndex[prefix]) {
                    tempData[prefix].append(contactName)
                    foundPrefix = true
                    break
                }
            }
            if foundPrefix == false {
                tempIndex.append(String(contactName.username.prefix(1)))
                var temp: [ContactDomain] = []
                temp.append(contactName)
                tempData.append(temp)
            }
        }
        
        // Sort by Alphabe
        for index in 0..<tempIndex.count-1 {
            for target in (index+1)..<tempIndex.count {
                if tempIndex[index].compare(tempIndex[target]).rawValue == 1 {
                    (tempIndex[index], tempIndex[target]) = (tempIndex[target], tempIndex[index])
                    (tempData[index], tempData[target]) = (tempData[target], tempData[index])
                }
            }
        }
        
        return (tempIndex, tempData)
    }
}
