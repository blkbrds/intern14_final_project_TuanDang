//
//  Api.Schedules.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import ObjectMapper

extension Api.Schedules {
    struct QueryString {

        /**
         * Get API URL.
         */
        func getUserSchedules() -> String {
            return Api.Path.baseURL + Api.Path.scheduleUrl
        }
    }
    
//    struct ScheduleResult {
//        var schedules : [ScheduleDomain]
//    }
    
    /**
     * Dummy data to display.
     */
    static func getDummyData() -> [ScheduleDomain] {
        let schedule = ScheduleDomain()
        schedule.id = "123"
        schedule.scheduleContent = "new content"
        schedule.scheduleTitle = "Schedule title"
        
        var schedules = [ScheduleDomain]()
        schedules.append(schedule)
        return schedules;
    }
    
    /**
     * Get all schedules.
     */
    static func getSchedules(withPage: Int = 0, numberOfRecordsPerIndex: Int = 10, completion: @escaping Completion<[ScheduleDomain]>) {
        
        // MARK: Call to REST url.
        let urlString = self.QueryString().getUserSchedules()
        var params: [String: String] = [:]
        params["from_date"] = "2019-10-27"
        params["to_date"] = ""
        params["filter_status"] = "1"
        params["page_index"] = String(withPage)
        params["page_size"] = String(numberOfRecordsPerIndex)
        params["column_sort"] = "id"
        params["type_sort"] = "ASC"
        
        api.request(method: .get, urlString: urlString, parameters: params,
                    headers: ApiManager().defaultHTTPHeaders) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let value = value as? JSObject {
                        var schedules = [ScheduleDomain]()
                        if let data = value["data"] as? JSArray {
                            print("Response value : \(value)")
                            schedules = Mapper<ScheduleDomain>().mapArray(JSONArray: data)
                            print("Search result: \(schedules)")
                        }

                        completion(.success(schedules))
                    } else {
                        completion(.failure(Api.Error.json))
                        return
                    }

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        
//        print("Go ahead.")
//        let schedules = getDummyData()
//        completion(.success(schedules))
    }
}
