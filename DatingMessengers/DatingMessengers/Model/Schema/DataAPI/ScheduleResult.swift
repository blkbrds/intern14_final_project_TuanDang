//
//  ScheduleResult.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/28/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import ObjectMapper

final class ScheduleResult: Mappable {

    var schedules: [ScheduleDomain] = []
    var totalRow: Int = 0
 
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        totalRow <- map["total_rows"]
    }
}
