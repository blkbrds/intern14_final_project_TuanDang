//
//  ScheduleCellViewModel.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/26/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import Foundation

class ScheduleCellViewModel {
    var timeSchedule: String?
    var contentSchedule: String?
    var status: AcceptStatus
    
    init(schedule: ScheduleObject) {
        self.timeSchedule = schedule.scheduleStartTime
        self.contentSchedule = schedule.scheduleContent
        self.status = schedule.acceptStatus
    }
}

