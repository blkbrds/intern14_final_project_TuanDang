//
//  ContactCellViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/29/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import UIKit

class ContactCellViewModel {
    
    var id: String = ""
    var username: String = ""
    var aliasName: String = ""
    var imgUrl: String = ""
    
    init(contact: ContactDomain) {
        self.id = contact.id
        self.username = contact.username
        self.aliasName = contact.aliasName
        self.imgUrl = contact.imgUrl
    }
}
