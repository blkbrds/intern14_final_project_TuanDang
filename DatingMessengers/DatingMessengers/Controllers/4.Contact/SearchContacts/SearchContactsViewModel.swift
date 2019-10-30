//
//  SearchContactsViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/30/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

final class SearchContactsViewModel {
    
    var contacts: [ContactDomain]?
    
    func searchUser(byName: String?, byAlias: String?, completion: @escaping APICompletion) {
        Api.Contacts.findContactByNameOrAlias(byName: byName, byAlias: byAlias) { result in
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
}
