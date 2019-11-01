//
//  ContactDomain.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/28/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

@objcMembers class ContactDomain: Object, Mappable {
    
    // Declare propeties
    enum Property: String {
    case id, username, aliasName, imgUrl
    }
    
    // for Realms column.
    dynamic var id: String = ""
    dynamic var username: String = ""
    dynamic var aliasName: String = ""
    dynamic var imgUrl: String = ""
    var imageView = UIImage(named: "userImage")
    
    // Detect primary key.
    static override func primaryKey() -> String? {
        return ContactDomain.Property.id.rawValue
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        aliasName <- map["alias_name"]
        imgUrl <- map["img_url"]
    }
    
    convenience init(id: String, username: String, alias: String, img: String) {
        self.init()
        self.id = id
        self.username = username
        self.aliasName = alias
        self.imgUrl = img
    }
    
    // Function (test method) write object to realm.
    func add() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
}

/**
 * Interact with Realm data.
 */
extension ContactDomain {
    static func add(id: String, username: String, alias: String, img: String, in realm: Realm = try! Realm()) -> ContactDomain {
        let contact = ContactDomain(id: id, username: username, alias: alias, img: img)
        try! realm.write {
            realm.add(contact)
        }
        return contact
    }
}
