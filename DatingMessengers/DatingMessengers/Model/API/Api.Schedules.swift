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
    
    struct QueryParams {
        
        /**
         * Get params for GET method.
         */
        func getFilterParams(withPage: Int = 0, numberOfRecordsPerIndex: Int = 10, fromDate: String = "2019-10-27", toDate: String = "", joinStatus: String = "1", sortBy: String = "id", sortType: String = "ASC") -> [String: String] {
            var params: [String: String] = [:]
            params["from_date"] = fromDate
            params["to_date"] = toDate
            params["filter_status"] = joinStatus
            params["page_index"] = String(withPage)
            params["page_size"] = String(numberOfRecordsPerIndex)
            params["column_sort"] = sortBy
            params["type_sort"] = sortType
            return params
        }
    }
    
    /**
     * Get all schedules.
     */
    static func getSchedules(withPage: Int = 0, numberOfRecordsPerIndex: Int = 10, completion: @escaping Completion<ScheduleResult>) {
        
        // MARK: Call to REST url.
        let urlString = self.QueryString().getUserSchedules()
        let params = self.QueryParams.init().getFilterParams(withPage: withPage, numberOfRecordsPerIndex: numberOfRecordsPerIndex)
        
        api.request(method: .get, urlString: urlString, parameters: params,
                    headers: ApiManager().defaultHTTPHeaders) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let value = value as? JSObject {

                        if let searchResult = Mapper<ScheduleResult>().map(JSON: value) {
                            if let data = value["data"] as? JSArray, let rows = value["total_rows"] as? Int {
                                let schedules = Mapper<ScheduleDomain>().mapArray(JSONArray: data)
                                searchResult.schedules = schedules
                                searchResult.totalRow = rows
                                completion(.success(searchResult))
                            }
                        } else  {
                            completion(.failure(Api.Error.json))
                            return
                        }
                        
                    } else {
                        completion(.failure(Api.Error.json))
                        return
                    }

                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
