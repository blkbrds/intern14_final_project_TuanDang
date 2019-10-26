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
    
    /**
     * Get all schedules.
     */
    static func getSchedules(pageIndex: Int, recordsInPage: Int, completion: @escaping Completion) {
            
        // Querry call to URL.
        let urlString = QueryString().getUserSchedules()
        
//        Api.shared.request(urlString: urlString) { (result) in
//            switch result {
//            case .failure(let error):
//                print(error.localizedDescription)
//                completion(.failure(error))
//            case .success(let data):
//                if let data = data {
//                    let json = data.convertToJSON()
//                    let schedule = ScheduleObject(json: json)
//                    var schedules = [ScheduleObject]()
//                    schedules.append(schedule)
//                    completion(.success(ScheduleResult(schedules: schedules)))
//                } else {
//                    completion(.failure(.error("Data is not format.")))
//                }
//            }
//        }
    }
}
