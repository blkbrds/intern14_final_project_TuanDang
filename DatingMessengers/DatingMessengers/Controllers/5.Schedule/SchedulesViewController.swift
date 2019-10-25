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
    var viewModel: SchedulesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func settingData() {
        let scheduleCell = UINib(nibName: ScheduleIdentity.nib.name, bundle: nil)
        scheduleTableView.register(scheduleCell, forCellReuseIdentifier: ScheduleIdentity.table.name)
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        
        // MARK: Reload data.
        if let viewModel = viewModel {
            viewModel.getSchedules { _ in
                self.scheduleTableView.reloadData()
            }
        }
    }
}

extension SchedulesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let viewModel = viewModel {
            return viewModel.numberOfSections()
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.numberOfRowsInSection()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleIdentity.table.name, for: indexPath) as? ScheduleTableViewCell else {
            return UITableViewCell()
        }
//        if let viewModel = viewModel {
//            cell.viewModel = viewModel.cellViewModel(at: indexPath)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController = ScheduleDetailViewController()
//
//        if let viewModel = viewModel {
//            let detailModelView = viewModel.detailViewModel(at: indexPath)
//            detailViewController.viewModel = detailModelView
//        }
//
//        navigationController?.pushViewController(detailViewController, animated: true)
        // MARK: Source code change to detail page.
    }
}
