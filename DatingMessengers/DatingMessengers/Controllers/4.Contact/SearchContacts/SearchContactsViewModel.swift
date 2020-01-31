//
//  SearchContactsViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/30/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

final class SearchContactsViewModel {
    
    var contacts: [ContactDomain] = []
    private var addedContacts = [ContactDomain]()
    
    func searchUser(by: String?, completion: @escaping APICompletion) {
        Api.Contacts.findContactByNameOrAlias(byName: by) { result in
            switch result {
            case .success(let contactResult):
                self.contacts = contactResult
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        completion(.success)
    }
    
    func numberOfRowsInSection() -> Int {
        return contacts.count
    }
    
    func cellModel(at: IndexPath) -> String {
        return contacts[at.row].aliasName
    }

    func getCellModel(at: Int) -> ContactCellViewModel {
        return ContactCellViewModel(contact: contacts[at])
    }
    
    func addContact(contact: ContactDomain) {
        addedContacts.append(contact)
    }
    
    func removeContact(id: String) {
        for contact in addedContacts {
            if contact.id.elementsEqual(id) {
                let _ = addedContacts.remove(contact)
            }
        }
    }
    
    /**
     * Update contact to DB.
     */
    func addFriends() {
        if addedContacts.count > 0 {
            RealmManager.shared.add(objects: addedContacts)
        }
    }
}
