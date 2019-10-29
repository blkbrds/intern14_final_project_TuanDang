//
//  ContactsViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit
import RealmSwift

class ContactsViewController: ViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    var viewModel = ContactsViewModel()
    let myIdentity = "myTableView"
    let nibFileName = "ContactViewCell"
    
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
        
        let nib = UINib(nibName: nibFileName, bundle: nil)
        contactsTableView.register(nib, forCellReuseIdentifier: myIdentity)
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
//        let realm = try! Realm()
//        notificationToken = viewModel.contacts
        
//        (viewModel.contactsIndex, viewModel.contacts) = createContactsIndex()
    }
    
    func loadGroupArrayFromPlist(plistName: String) -> [[String]] {
        var groupArray: [[String]] = [[]]
        guard let path = Bundle.main.url(forResource: plistName, withExtension: "plist") else { return groupArray }
        guard let animalsPlist = NSArray(contentsOf: path) as? [Any]  else { return groupArray }
        
        for index in 0..<animalsPlist.count {
            guard let myArray = animalsPlist[index] as? [String] else { return groupArray }
            groupArray.append(myArray)
        }
        groupArray.remove(at: 0)
        return groupArray
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: myIdentity, for: indexPath) as? ContactViewCell else {
            return UITableViewCell()
        }
        cell.userName.text = viewModel.contacts[indexPath.section][indexPath.row].username
        return cell
    }
    
    /**
     * Setting header section.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.contactsIndex.count > 0 {
            return viewModel.contactsIndex[section]
        } else { return nil }
    }
    
    /**
     * Index content.
     */
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return  viewModel.contactsIndex
    }
    
    /*
     * Setting index for table view.
     */
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
}
