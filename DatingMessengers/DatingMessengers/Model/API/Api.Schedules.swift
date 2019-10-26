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
    static func getSchedules(pageIndex: Int = 0, recordsInPage: Int = 10, completion: @escaping Completion<SchemaResponse>) {
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
                    guard let value = value as? JSObject,
                        let searchResult = Mapper<YouTubeResult>().map(JSON: value) else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    completion(.success(searchResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
