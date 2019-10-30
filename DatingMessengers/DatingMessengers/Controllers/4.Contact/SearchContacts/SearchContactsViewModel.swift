//
//  SearchContactsViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/30/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

final class SearchContactsViewModel {
    func searchUser(byName: String?, byAlias: String?, completion: @escaping APICompletion) {
//        Api.Contacts.getContacts
        completion(.success)
    }
}
