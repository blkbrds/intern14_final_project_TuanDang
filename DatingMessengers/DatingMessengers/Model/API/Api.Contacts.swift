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
    
    static func dowloadImage(url: String, completion: @escaping Completion<Data?>) {
        let imageUrl = URL(string:url)!
        getData(from: imageUrl) { data, response, error in
            if let data = data, error == nil {
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    completion(.success(data))
                }
            } else {
                completion(.failure(error!))
                return
            }
        }
    }
    
    private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
