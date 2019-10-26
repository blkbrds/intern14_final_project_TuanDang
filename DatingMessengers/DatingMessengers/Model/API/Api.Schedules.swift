//
//  Api.Schedules.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

extension Api.Schedules {
    struct QueryString {

        /**
         * Get API URL.
         */
        func getUserSchedules() -> String {
            return Api.Path.baseURL + Api.Path.scheduleUrl
        }
    }
    
    struct ScheduleResult {
        var schedules : [ScheduleObject]
    }
    
    static func getDummyData() -> [ScheduleObject] {
        let schedule = ScheduleObject()
        schedule.id = "123"
        schedule.scheduleContent = "new content"
        schedule.scheduleTitle = "Schedule title"
        
        var schedules = [ScheduleObject]()
        schedules.append(schedule)
        return schedules;
    }
    
    /**
     * Get all schedules.
     */
    static func getSchedules(withPage: Int, numberOfRecordsPerIndex: Int, completion: ([ScheduleObject]) -> Void) {
        let schedules = getDummyData()
        completion(schedules)
    }
}
