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
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func settingData() {
        scheduleTableView.register(UITableViewCell.self, forCellReuseIdentifier: ScheduleIdentity.table.name)
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
        reloadData()
    }
    
    private func reloadData() {
        self.isLoading = true
        viewModel.getSchedules { result in
            self.isLoading = false
            switch result {
            case .success:
                self.scheduleTableView.reloadData()
//                DispatchQueue.main.async {
//                    self.scheduleTableView.reloadData()
//                }
            case .failure(let error):
                print(error)
            }
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

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.schedules.count - 1
        if indexPath.row == lastElement && !isLoading {
            reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: Source code change to detail page.
        print("Click to row : \(indexPath.row)")
    }
}
