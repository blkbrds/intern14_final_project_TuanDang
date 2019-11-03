//
//  Api.Contacts.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import ObjectMapper

extension Api.Contacts {
 
    struct QueryString {

        /**
         * Get API URL.
         */
        func getUserContacts() -> String {
            return Api.Path.baseURL + Api.Path.contactUrl + "/list"
        }
        
        /**
         * Get API URL search  .
         */
        func searchContactByUserOrAlias() -> String {
            return Api.Path.baseURL + Api.Path.contactUrl
        }
    }
    
    struct QueryParams {
        
        /**
         * Get params for GET method.
         */
        func getFilterParams(byValue: String) -> [String: String] {
            var params: [String: String] = [:]
            params["value"] = byValue
            return params
        }
    }

    /**
     * Get all schedules.
     */
    static func getContacts(completion: @escaping Completion<[ContactDomain]>) {
        
        // MARK: Call to REST url.
        let urlString = self.QueryString().getUserContacts()
        
        api.request(method: .get, urlString: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let value = value as? JSArray {
                        let contacts = Mapper<ContactDomain>().mapArray(JSONArray: value)
                        completion(.success(contacts))
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
    
    /**
     * Search contact by username or alias name.
     */
    static func findContactByNameOrAlias(byName: String?, completion: @escaping Completion<[ContactDomain]>) {
        print("Parameter value: \(byName ?? "empty value")")
        if let byName = byName {
            let urlString = self.QueryString().searchContactByUserOrAlias()
            let requestParams = self.QueryParams().getFilterParams(byValue: byName)
            
            api.request(method: .get, urlString: urlString, parameters: requestParams,
                        headers: ApiManager().defaultHTTPHeaders) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        if let value = value as? JSArray {
                            print("Response value: \(value)")
                            let contacts = Mapper<ContactDomain>().mapArray(JSONArray: value)
                            completion(.success(contacts))
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
        completion(.success([]))
    }
        
//    static func getDataFromUrl(url:String, completion: ((_ data: Data?) -> Void)) {
//        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
//            guard let data = data else { return }
//            completion(Data(data))
//        }.resume()
//    }
    
    private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
