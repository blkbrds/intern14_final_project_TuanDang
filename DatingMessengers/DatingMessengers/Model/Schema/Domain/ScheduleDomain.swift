//
//  ScheduleObject.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//
import Foundation
import RealmSwift
import ObjectMapper

enum AcceptStatus: String {
    case Accept
    case Reject
    case New
    case Expired
}

@objcMembers final class ScheduleObject: Object, Mappable {

    dynamic var id = ""
    dynamic var scheduleStartDate = ""
    dynamic var scheduleStartTime = ""
    dynamic var scheduleEndDate = ""
    dynamic var scheduleEndTime = ""
    dynamic var scheduleTitle = ""
    dynamic var scheduleContent = ""
    dynamic var acceptStatus = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

    required convenience init?(map: Map) {
        self.init()
    }

    convenience init(json: JSObject) {
        var schema: [String: Any] = [:]
        
        if let data = json["data"] as? JSObject {
            if let id = data["id"] {
                schema["id"] = id
            }
            if let title = data["title"] {
                schema["title"] = title
            }
            // Start time.
            if let timeStart = data["time_start"] {
//                 if let beginTime = Helper.shared.convertStringToComponents(from: timeStart) {
//                    self.scheduleStartDate = String(beginTime.day!) + "/" + String(beginTime.month!)
//                    self.scheduleStartTime = String(beginTime.hour!) + ":" + String(beginTime.minute!)
//                }
                schema["timeStart"] = timeStart
            }
            // End time.
            if let timeEnd = data["time_end"] as? String {
//                if let endTime = Helper.shared.convertStringToComponents(from: timeEnd) {
//                    self.scheduleEndDate = String(endTime.day!) + "/" + String(endTime.month!)
//                    self.scheduleEndTime = String(endTime.hour!) + ":" + String(endTime.minute!)
//                }
                schema["timeEnd"] = timeEnd
            }
            if let content = data["content"] as? String {
                schema["content"] = content
            }
            if let map = data["map_location"] as? String {
                print("Location : \(map)")
            }
            if let status = json["status"] as? String {
                print("Status : \(status)")
            }
        }
        
        // MARK : Not yet to do.
//        if let snippet = json["snippet"] as? JSObject {
//            if let title = snippet["title"] {
//                schema["title"] = title
//            }
//            if let publishedAt = snippet["publishedAt"] {
//                schema["publishedAt"] = publishedAt
//            }
//            if let channelTitle = snippet["channelTitle"] {
//                schema["channelTitle"] = channelTitle
//            }
//            if let description = snippet["description"] {
//                schema["description"] = description
//            }
//            if let thumbnails = snippet["thumbnails"] as? JSObject {
//                if let high = thumbnails["high"] as? JSObject {
//                    if let url = high["url"] {
//                        schema["url"] = url
//                    }
//                }
//            }
//        }

        self.init(value: schema)
    }

    func mapping(map: Map) {
        id <- map["id.videoId"]
        scheduleStartDate <- map["snippet.title"]
        scheduleStartTime <- map["snippet.thumbnails.high.url"]
        scheduleEndDate <- map["snippet.publishedAt"]
        scheduleEndTime <- map["snippet.channelTitle"]
        scheduleTitle <- map["snippet.description"]
    }
}
