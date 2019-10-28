//
//  SchedulesViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

class SchedulesViewModel {
    
    var schedules: [ScheduleDomain] = []
    var isNextPage = true
    var startPage = 0
    var stopLoad = false

    init() {}
    
    /**
     * Get days have schedule.
     */
    func numberOfSections() -> Int {
        return 1
    }
    
    /**
     * Return schedules per day.
     */
    func numberOfRowsInSection() -> Int {
        return schedules.count
    }
    
    /**
     * Return
     */
    func cellViewModel(at indexPath: IndexPath) -> ScheduleCellViewModel {
        return ScheduleCellViewModel(schedule: schedules[indexPath.row])
    }
    
    /**
     * Load data from Rest API.
     */
    func getSchedules(completion: @escaping APICompletion) {
        Api.Schedules.getSchedules(withPage: startPage, numberOfRecordsPerIndex: Api.SystemConfig.defautPageSize) { result in
            switch result {
            case .success(let schedulesResult):
                self.schedules.append(contentsOf: schedulesResult.schedules)
                self.startPage += 1
                if (self.startPage * Api.SystemConfig.defautPageSize >= schedulesResult.totalRow) {
                    self.isNextPage = false
                }
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /**
     * Call to Load more method.
     */
    func getNextSchedules(completion: @escaping APICompletion) {
        if self.isNextPage == false {
            completion(.success)
        } else {
            getSchedules(completion: completion)
        }
    }
    
}
