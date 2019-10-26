//
//  RequestSerializer.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Alamofire
import Foundation

extension ApiManager {
    
    @discardableResult
    func request(method: HTTPMethod,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 completion: Completion?) -> Request? {
        guard Network.shared.isReachable else {
            completion?(.failure(Api.Error.network))
            return nil
        }

        let encoding: ParameterEncoding
        if method == .post {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }

        var _headers = api.defaultHTTPHeaders
        _headers.updateValues(headers)

        let request = Alamofire.request(urlString.urlString,
                                        method: method,
                                        parameters: parameters,
                                        encoding: encoding,
                                        headers: _headers
        ).responseJSON(completion: { (response) in
            if let error = response.error,
                error.code == Api.Error.connectionAbort.code || error.code == Api.Error.connectionWasLost.code {
                Alamofire.request(urlString.urlString,
                                  method: method,
                                  parameters: parameters,
                                  encoding: encoding,
                                  headers: _headers
                    ).responseJSON { response in
                        completion?(response.result)
                }
            } else {
                completion?(response.result)
            }
        })
        
        return request
    }
    
    func request(with urlString: String, completion: @escaping () -> Void) {
        guard let url = URL(string: urlString) else { return }
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.request(data: [:], error: error)
            } else {
                if let data = data {
                    let json = self.convertToJSON(from: data)
                    self.delegate?.request(data: json, error: nil)
                } else {
                    self.delegate?.request(data: [:], error: nil)
                }
            }
            completion()
        }
        task.resume()
    }
    
    /**
     * Convert response data to JSON.
     */
    private func convertToJSON(from data: Data) -> [String: Any] {
           var json: [String: Any] = [:]
           do {
               if let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                   json = jsonObj
               }
           } catch {
               print("JSON casting error")
           }
           return json
       }
}
