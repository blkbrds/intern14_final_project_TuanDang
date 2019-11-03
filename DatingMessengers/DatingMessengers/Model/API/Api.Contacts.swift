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
