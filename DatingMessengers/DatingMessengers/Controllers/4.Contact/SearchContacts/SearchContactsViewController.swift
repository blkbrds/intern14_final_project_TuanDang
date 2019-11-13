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
        let nib = UINib(nibName: "ContactsSearchedViewCell", bundle: nil)
        userFoundTableView.register(nib, forCellReuseIdentifier: "Myidentity")
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
        viewModel.addFriends()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Myidentity", for: indexPath) as? ContactsSearchedViewCell else {
            return ContactViewCell()
        }
        cell.viewModel = viewModel.getCellModel(at: indexPath.row)

        return cell
    }
}

extension SearchContactsViewController: ContactsSearchedViewCellDelegate {
    func markContactAdd(view: ContactsSearchedViewCell, contact: ContactDomain) {
        viewModel.addContact(contact: contact)
    }
    
    func markContactRemove(view: ContactsSearchedViewCell, id: String) {
        viewModel.removeContact(id: id)
    }
}
