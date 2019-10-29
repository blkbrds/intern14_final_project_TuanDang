//
//  ContactsViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

enum ContactIdentity: String {
    case table
    case cell
    case nib
    
    var name: String {
        switch self {
        case .table: return "ContactsTable"
        case .cell: return "ContactCell"
        case .nib: return "ContactTableViewCell"
        }
    }
}

class ContactsViewController: ViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    var viewModel = ContactsViewModel()
    
    // MARK: Notification from Realm
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     * Config to set data.
     */
    override func setupData() {

        // MARK: Load data from server.
        let nib = UINib(nibName: ContactIdentity.nib.name, bundle: nil)
        contactsTableView.register(nib, forCellReuseIdentifier: ContactIdentity.table.name)
        contactsTableView.dataSource = self
        
        viewModel.getContacts { result in
            switch result {
            case .success:
                self.contactsTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        // MARK: Create Realm Observe
        viewModel.notificationToken = viewModel.originalContacts.observe { (result) in
            switch result {
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.contactsTableView.reloadData()
                print("Display result update.")
            case .initial(_):
                self.contactsTableView.reloadData()
                print("Display result initial.")
                break
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ContactsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactIdentity.cell.name, for: indexPath) as? ContactViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = viewModel.getCellModel(at: indexPath)
        return cell
    }
    
    /**
     * Setting header section.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getHeader(at: section)
    }
    
    /**
     * Index content.
     */
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.getSectionIndex()
    }
    
    /*
     * Setting index for table view.
     */
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}
