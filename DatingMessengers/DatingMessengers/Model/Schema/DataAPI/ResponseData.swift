//
//  ResponseResult.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/26/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

final class ResponseData<T, E> {
    private var _data: T?
    private var _totalRows: Int?
    private var _errors: E?
    private var _message: String?
    private var _offset: Int?
    private var _limit: Int?
    private var _success: Bool = true
    
    private init() { }
    init(data: T?, totalRows: Int?, errors: E?, message: String?, offset: Int, limit: Int?, success: Bool = true) {
        _data = data
        _totalRows = totalRows
        _errors = errors
        _message = message
        _offset = offset
        _limit = limit
        _success = success
    }
    
    public var data: T? {
        set {
            _data = newValue
        }
        get {
            return _data
        }
    }
    public var totalRows: Int? {
        set {
            _totalRows = newValue
        }
        get {
            return _totalRows
        }
    }
    public var errors: E? {
        set {
            _errors = newValue
        }
        get {
            return _errors
        }
    }
    public var message: String? {
        set {
            _message = newValue
        }
        get {
            return _message
        }
    }
    private var offset: Int? {
        set {
            _offset = newValue
        }
        get {
            return _offset
        }
    }
    private var limit: Int? {
        set {
            _limit = newValue
        }
        get {
            return _limit
        }
    }
    private var success: Bool {
        set {
            _success = newValue
        }
        get {
            return _success
        }
    }
}
