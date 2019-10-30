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
}
