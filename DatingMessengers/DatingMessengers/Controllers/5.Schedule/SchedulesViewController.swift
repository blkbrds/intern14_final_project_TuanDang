//
//  SchedulesViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

enum ScheduleIdentity: String {
    case table
    case cell
    case nib
    
    var name: String {
        switch self {
        case .table: return "SchedulesTable"
        case .cell: return "ScheduleCell"
        case .nib: return "ScheduleTableViewCell"
        }
    }
}

class SchedulesViewController: ViewController {

    @IBOutlet weak var scheduleTableView: UITableView!
    var viewModel = SchedulesViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func settingData() {
        scheduleTableView.register(UITableViewCell.self, forCellReuseIdentifier: ScheduleIdentity.table.name)
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        
        viewModel.getSchedules(withPage: 0, numberOfRecordsPerIndex: 10) {
            scheduleTableView.reloadData()
        }
    }
}

extension SchedulesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleIdentity.table.name, for: indexPath)
        cell.textLabel?.text = viewModel.cellViewModel(at: indexPath).scheduleTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: Source code change to detail page.
        print("Click to row : \(indexPath.row)")
    }
}
