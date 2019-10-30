//
//  SearchContactsViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/30/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

protocol SearchContactsViewDelegate: class {
    func addButtonClick(view: SearchContactsViewController, usersSelected usersId: [String]?)
    func cancelButtonClick(view: SearchContactsViewController)
}

class SearchContactsViewController: UIViewController {

    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userFoundTableView: UITableView!
    
    var delegate: SearchContactsViewDelegate?
    private var usersSelected: [String]?
    private var viewModel = SearchContactsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
            setupData()
        }
        
    /**
     * Required method to setting layout.
     */
    func setupUI() {
        userFoundTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Myidentity")
        userFoundTableView.dataSource = self

        userSearchBar.returnKeyType = .search
        userSearchBar.delegate = self
    }
    
    /**
     * Config to set data.
     */
    func setupData() { }

    @IBAction func addFriendsButtonClick(_ sender: UIButton) {
        delegate?.addButtonClick(view: self, usersSelected: usersSelected)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelSearchButtonClick(_ sender: UIButton) {
        delegate?.cancelButtonClick(view: self)
        dismiss(animated: true, completion: nil)
    }
}

extension SearchContactsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("Start search")

        viewModel.searchUser(by: userSearchBar.text) { result in
            switch result {
            case .success:
                self.userFoundTableView.reloadData()
                break;
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Myidentity", for: indexPath)
        cell.textLabel?.text = viewModel.cellModel(at: indexPath)
        return cell
    }
    
    
}
