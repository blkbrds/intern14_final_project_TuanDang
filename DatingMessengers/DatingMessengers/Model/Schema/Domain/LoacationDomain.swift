//
//  LoacationDomain.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/27/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import ObjectMapper

final class LoacationDomain: Mappable {
    var latitude: String?
    var longitude: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
