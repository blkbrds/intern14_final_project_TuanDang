//
//  ContactsViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/28/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import RealmSwift

class ContactsViewModel {

    var contacts: [[ContactDomain]] = [[]]
    var contactsIndex: [String] = []
    var originalContacts: Results<ContactDomain> = try! Realm().objects(ContactDomain.self)
    var notificationToken: NotificationToken? = nil

    var isNextPage = true
    var startPage = 0
    let plistName = "ContactsFile"
    
    init() { }
    
    func numberOfSections() -> Int {
        return contacts.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return contacts[section].count
    }
    
//    func cellViewModel(at: IndexPath) -> ContactCellViewModel {
//        let result = ContactCellViewModel(contact: ContactDomain())
//        return result
//    }
    func getCellModel(at: IndexPath) -> ContactCellViewModel {
        return ContactCellViewModel(contact: contacts[at.section][at.row])
    }
    
    func getContacts(completion: @escaping APICompletion) {
        
        // MARK: Call to API fetch datas.
        Api.Contacts.getContacts() {
            result in
            switch result {
            case .success(let contactsResult):
                let addedContacts = self.syncResponseDataWithRealm(data: contactsResult)
                if self.saveRealm(data: addedContacts) == false {
                    // MARK: Show error update to realm.
                    completion(.failure(Api.Error.saveRealmNotSuccess))
                }
                
                // Load data from Realm and set to
                (self.contactsIndex, self.contacts) = self.createContactsIndex(contactsData: self.originalContacts.reversed())

                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /**
     * Add new contacts to Realm
     */
    private func syncResponseDataWithRealm(data: [ContactDomain]) -> [ContactDomain] {
        var sameValue = false
        var addedObjects: [ContactDomain] = []
        
        print("have total \(originalContacts.count) records")
        
        for domain in data {
            sameValue = false
            for contact in originalContacts {
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
    
//    func test() -> NotificationToken {
//        return originalContacts.observe { (result) in
//            switch result {
//            case .update(let result, deletions: _, insertions: _, modifications: _):
//                print(result.count)
//            case .initial(let result):
//                print(result.count)
//                break
//            case .error(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    /**
     * Demo add object to realm.
     */
    private func saveRealm(data: [ContactDomain]) -> Bool {
        let realm = try! Realm()
        try! realm.write {
            for contact in data {
                realm.add(contact)
            }
        }
        
//        let domain = ContactDomain.add(id: "3", username: "my username", alias: "Ten cua mot nguoi", img: "abcd.png")
//        print("Content save to Realm as bellow: ")
//        print("ID: \(domain.id)")
//        print("User name: \(domain.username)")
//        print("Alias name: \(domain.aliasName)")
//        print("IMG: \(domain.imgUrl)")
//        let data = ContactDomain(id: "4", username: "asdf", alias: "sdf", img: "sdfwe")
        return true
    }
    
    private func loadArrayFromPlist(plistName: String) -> [String] {
        let emptyArray: [String] = []
        guard let path = Bundle.main.url(forResource: plistName, withExtension: "plist") else { return emptyArray }
        guard let userData = NSArray(contentsOf: path) as? [String] else { return emptyArray }
        return userData
    }
    
    /**
     * Sort by name.
     */
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
