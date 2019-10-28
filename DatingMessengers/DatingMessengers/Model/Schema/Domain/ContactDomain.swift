//
//  ContactDomain.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/28/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import ObjectMapper

class ContactDomain: Mappable {
    
    var id: String = ""
    var username: String = ""
    var aliasName: String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        aliasName <- map["alias_name"]
    }
}
