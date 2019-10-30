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
         * Get API URL.
         */
        func searchContactByUserOrAlias() -> String {
            return Api.Path.baseURL + Api.Path.contactUrl
        }
    }
    
    struct QueryParams {
        
        /**
         * Get params for GET method.
         */
        func getFilterParams(byName: String?, byAlias: String?) -> [String: String] {
            var params: [String: String] = [:]
            params["name"] = byName ?? ""
            params["alias"] = byAlias ?? ""
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
    
    static func findContactByNameOrAlias(byName: String?, byAlias: String?, completion: @escaping Completion<[ContactDomain]>) {
        
        let urlString = QueryString().getUserContacts()
        
        
        
        completion(.success([]))
    }
}
