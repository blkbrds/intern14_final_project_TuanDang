//
//  ContactsViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

class ContactsViewController: ViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    var viewModel = ContactsViewModel()
    let plistName = "ContactsFile"
    let myIdentity = "myTableView"
    let nibFileName = "ContactViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /**
     * Config to set data.
     */
    override func setupData() {

        // MARK: Load data from server.
//        (contactsIndex, contacts) = createContactsIndex()
        let nib = UINib(nibName: nibFileName, bundle: nil)
        contactsTableView.register(nib, forCellReuseIdentifier: myIdentity)
        contactsTableView.dataSource = self
    }
    
    /**
     * Sort by name.
     */
    private func createContactsIndex() -> ([String], [[String]]) {
        
        let animalsData = loadArrayFromPlist(plistName: plistName)
        var tempData: [[String]] = [[]]
        var tempIndex: [String] = []
        // Create index by prefix animal name.
        tempData.remove(at: 0)
        for animalName in animalsData {
                var foundPrefix = false
                for prefix in 0..<tempIndex.count {
                    if animalName.prefix(1).elementsEqual(tempIndex[prefix]) {
                        tempData[prefix].append(animalName)
                        foundPrefix = true
                        break
                    }
                }
                if foundPrefix == false {
                    tempIndex.append(String(animalName.prefix(1)))
                    var temp: [String] = []
                    temp.append(animalName)
                    tempData.append(temp)
                }
        }
        
        // Sort by Alphabe
        for index in 0..<tempIndex.count-1 {
            for target in (index+1)..<tempIndex.count {
                if tempIndex[index].compare(tempIndex[target]).rawValue == 1 {
                    (tempIndex[index], tempIndex[target]) = (tempIndex[target], tempIndex[index])
                    (tempData[index], tempData[target]) = (tempData[target], tempData[index])
                }
            }
        }
        
        return (tempIndex, tempData)
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
    
    func loadArrayFromPlist(plistName: String) -> [String] {
        let emptyArray: [String] = []
        guard let path = Bundle.main.url(forResource: plistName, withExtension: "plist") else { return emptyArray }
        guard let userData = NSArray(contentsOf: path) as? [String] else { return emptyArray }
        return userData
    }
}

extension ContactsViewController: ContactViewCellDelegate {
    func tapButtonClick(view: ContactViewCell) {
        guard let rowIndex = view.indexPath?.row else { return }
        print("Tap me : \(String(rowIndex))")
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
        cell.userName.text = viewModel.cellViewModel(at: indexPath).username
        return cell
    }
    
    /**
     * Setting header section.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.contactsIndex[section]
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
