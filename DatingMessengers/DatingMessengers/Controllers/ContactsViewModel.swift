//
//  ContactsViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/28/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

class ContactsViewModel {

    var contacts: [[String]] = [[]]
    var contactsIndex: [String] = []

    var isNextPage = true
    var startPage = 0
    
    init() { }
    
    func numberOfSections() -> Int {
        return contacts.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return contacts[section].count
    }
    
    func cellViewModel(at: IndexPath) -> ContactCellViewModel {
        let result = ContactCellViewModel(contact: ContactDomain())
        return result
    }
}
