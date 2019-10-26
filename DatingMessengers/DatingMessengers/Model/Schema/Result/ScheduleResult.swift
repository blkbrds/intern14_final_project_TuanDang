//
//  ScheduleResult.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/26/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

@objcMembers final class ScheduleResult: Object, Mappable {

    // MARK: - Propeties
    dynamic var kind = ""
    dynamic var nextPageToken = ""
    dynamic var prevPageToken = ""
    dynamic var items: [ScheduleObject] = []
    dynamic var videoName = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    convenience init(json: JSObjet) {
        var schema: [String: Any] = [:]
        if let kind = json["kind"] {
            schema["kind"] = kind
        }
        if let nextPageToken = json["nextPageToken"] {
            schema["nextPageToken"] = nextPageToken
        }
        if let prevPageToken = json["prevPageToken"] {
            schema["prevPageToken"] = prevPageToken
        }
//        if let items = json["items"] {
//            schema["items"] = items
//        }

        self.init(value: schema)
    }
    
    func mapping(map: Map) {
        kind <- map["kind"]
        nextPageToken <- map["nextPageToken"]
        prevPageToken <- map["prevPageToken"]
//        items <- map["items"]
    }
}
