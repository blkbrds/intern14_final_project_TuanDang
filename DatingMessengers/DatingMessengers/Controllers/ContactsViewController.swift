//
//  ContactsViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

enum ContactIdentity: String {
    case cell
    case nib
    
    var name: String {
        switch self {
        case .cell: return "ContactCell"
        case .nib: return "ContactViewCell"
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
        contactsTableView.register(nib, forCellReuseIdentifier: ContactIdentity.cell.name)
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        
        // MARK: 0. Mock action by Delegate.
        viewModel.delegate = self
        
        // MARK: 1. Fetch data from Realm and display to table.
        viewModel.fetchContactsToDisplay()

        // MARK: 2. Create observe listening realm change.
        viewModel.listeningRealmChange()

        // MARK: 3. Fetch data from Server.
        viewModel.getContacts { result in
            switch result {
            case .success:
                print("Call to server success.")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func downloadImages(paths: [IndexPath]?) {
        if let paths = paths {
            for indexPath in paths {
                viewModel.downloadImage(with: indexPath) { (indexPath, image) in
                    guard let cell = self.contactsTableView.dequeueReusableCell(withIdentifier: ContactIdentity.cell.name, for: indexPath) as? ContactViewCell else {
                        return
                    }
                    if let image = image {
                        cell.avatarImageView.image = image
                    } else {
                        cell.avatarImageView.image = UIImage(named: "userImage")
                    }
                }
            }
        }
    }
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Display current displayed in screen
        guard let visibleRows = contactsTableView.indexPathsForVisibleRows else { return }
        viewModel.reloadImageForCell(cells: visibleRows)
    }
}

// MARK: 3. Action when realm changing.
extension ContactsViewController: ContactsViewModelDelegate {
    func realmChanging(listeningBy: ContactsViewModel, action: RealmAction) {
        // MARK: Reload data when realm change.
        switch action {
        case .reloadTable:
            print("Action reload table")
        case .addNew:
            print("Add new data from API")
        case .update:
            print("Update data from Realm")
        default:
            print("Other action")
        }
        let indexPaths = contactsTableView.indexPathsForVisibleRows
        downloadImages(paths: indexPaths)
        self.contactsTableView.reloadData()
    }
}
