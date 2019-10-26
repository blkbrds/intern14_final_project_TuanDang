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
        func getUserSchedules(pageIndex: Int, pageSize: Int) -> String {
            return Api.Path.baseURL + Api.Path.scheduleUrl + "/\(pageIndex)"
        }
    }
    
    struct ScheduleResult {
        var schedules : [ScheduleObject]
    }
    
    /**
     * Dummy data to display.
     */
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
    static func getSchedules(withPage: Int = 0, numberOfRecordsPerIndex: Int = 10, completion: @escaping Completion<ScheduleObject>) {
        
        // MARK: Call to REST url.
        let urlString = self.QueryString().getUserSchedules(pageIndex: withPage, pageSize: numberOfRecordsPerIndex)
        
        api.request(method: .get, urlString: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let value = value as? JSObject {
                        print("Response value : \(value)")
                        let searchResult = ScheduleObject(json: value)
                        
                        print("Search result: \(searchResult.id)")
                        completion(.success(searchResult))
                    } else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        
        print("Go ahead.")
//        let schedules = getDummyData()
//        completion(schedules)
    }
}
