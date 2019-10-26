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
    
    static func getDummyData(completion: ([ScheduleObject]) -> Void) {
        let schedule = ScheduleObject()
        schedule.id = "123"
        schedule.scheduleContent = "new content"
        schedule.scheduleTitle = "Schedule title"
        
        var schedules = [ScheduleObject]()
        schedules.append(schedule)
    }
    
    /**
     * Get all schedules.
     */
    static func getSchedules(pageIndex: Int = 0, recordsInPage: Int = 10, completion: @escaping Completion) {
        // Querry call to URL.
        let urlString = QueryString().getUserSchedules()
        
//        api.request(with: urlString) { result in
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
        api.request(method: .get, urlString: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    guard let value = value as? JSObject //, let searchResult = Mapper<YouTubeResult>().map(JSON: value)
                        else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    print("Json value : \(value)")
                    completion(.success([]))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
