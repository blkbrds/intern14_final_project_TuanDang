//
//  ScheduleObject.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//
import Foundation
import ObjectMapper

enum AcceptStatus: String {
    case accept
    case reject
    case new
    case expired
}

final class ScheduleDomain: Mappable {

    var id: String = ""
    var scheduleStartDate: String = ""
    var scheduleStartTime: String = ""
    var scheduleEndDate: String = ""
    var scheduleEndTime: String = ""
    var scheduleTitle: String = ""
    var scheduleContent: String = ""
    var acceptStatus: String = ""

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        scheduleStartDate <- map["time_start"]
        scheduleStartTime <- map["time_start"]
        scheduleEndDate <- map["time_end"]
        scheduleEndTime <- map["time_end"]
        scheduleTitle <- map["title"]
        acceptStatus <- map["status"]
    }
}
