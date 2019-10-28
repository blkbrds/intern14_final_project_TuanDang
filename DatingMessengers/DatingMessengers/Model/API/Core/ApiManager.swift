//
//  ApiManager.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

// MARK: Interact with Resful
typealias Completion<Value> = (Result<Value>) -> Void
typealias APICompletion = (APIResult) -> Void

let api = ApiManager()

enum APIResult {
    case success
    case failure(Error)
}

final class ApiManager {
    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
}

// MARK: - Equatable
extension APIResult: Equatable {

    public static func == (lhs: APIResult, rhs: APIResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.failure(let lhsError), .failure(let rhsError)):
            return lhsError.code == rhsError.code && lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

// MARK: - Get error for api result
extension APIResult {

    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
