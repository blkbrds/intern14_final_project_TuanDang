//
//  Api.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

final class Api {
    
    static let shared = Api()
    private init() { }
    
    struct Path {
        #if DEBUG
            static let baseURL = "http://localhost:8080/ios"
        #elseif STG
            static let baseURL = "http://whoami.website/api/ios"
        #endif
        
        static let scheduleUrl = "/schedule"
    }
    
    struct Messages {}
    struct Schedules {}
    struct Contacts {}
    struct Maps {}
    struct Personally {}
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
