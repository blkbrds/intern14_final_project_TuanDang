//
//  SchedulesViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

class SchedulesViewModel {
    
    var schedules: [ScheduleObject] = []
    init() {}
    
    /**
     * Number of section. It will extend based on schedule day.
     */
    func numberOfSections() -> Int {
        return 1
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ScheduleCellViewModel {
        return ScheduleCellViewModel(schedule: schedules[indexPath.row])
    }
    
    func numberOfRowsInSection() -> Int {
        return schedules.count
    }
    
    func detailViewModel(at indexPath: IndexPath) -> ScheduleDetailViewModel {
        return ScheduleDetailViewModel(schedule: schedules[indexPath.row])
    }
    
    func getSchedules(completion: @escaping (Error?) -> Void) {
        Api.Schedules.getSchedules(pageIndex: 1, recordsInPage: 1) { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let scheduleResult):
                for schedule in (scheduleResult.schedules as AnyObject) {
                    self.schedules.append(schedule)
                }
                completion(nil)
            }
        }
    }
}
