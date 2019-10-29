//
//  RequestData.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/26/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

final class QueryParam<T> {
    private var query: T?
    private var pagingItem: PagingItem?
}

final class PagingItem {
    private var pageSize: Int?
    private var pageIndex: Int?
    private var directionSort: String?
    private var orderBy: String?
    private var totalRows: Int?
}
