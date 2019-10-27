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
    case Accept
    case Reject
    case New
    case Expired
}

final class ScheduleDomain: Mappable {

    var id: String?
    var scheduleStartDate: String?
    var scheduleStartTime: String?
    var scheduleEndDate: String?
    var scheduleEndTime: String?
    var scheduleTitle: String?
    var scheduleContent: String?
    var acceptStatus: String?

    required convenience init?(map: Map) {
        self.init()
    }

//    convenience init(json: JSObject) {
//        var schema: [String: Any] = [:]
//
//        if let data = json["data"] as? JSObject {
//            if let id = data["id"] {
//                schema["id"] = id
//            }
//            if let title = data["title"] {
//                schema["title"] = title
//            }
//            // Start time.
//            if let timeStart = data["time_start"] {
////                 if let beginTime = Helper.shared.convertStringToComponents(from: timeStart) {
////                    self.scheduleStartDate = String(beginTime.day!) + "/" + String(beginTime.month!)
////                    self.scheduleStartTime = String(beginTime.hour!) + ":" + String(beginTime.minute!)
////                }
//                schema["timeStart"] = timeStart
//            }
//            // End time.
//            if let timeEnd = data["time_end"] as? String {
////                if let endTime = Helper.shared.convertStringToComponents(from: timeEnd) {
////                    self.scheduleEndDate = String(endTime.day!) + "/" + String(endTime.month!)
////                    self.scheduleEndTime = String(endTime.hour!) + ":" + String(endTime.minute!)
////                }
//                schema["timeEnd"] = timeEnd
//            }
//            if let content = data["content"] as? String {
//                schema["content"] = content
//            }
//            if let map = data["map_location"] as? String {
//                print("Location : \(map)")
//            }
//            if let status = json["status"] as? String {
//                print("Status : \(status)")
//            }
//        }

//        self.init(value: schema)
//    }

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
