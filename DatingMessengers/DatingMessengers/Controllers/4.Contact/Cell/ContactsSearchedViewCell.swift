//
//  ContactsSearchedViewCell.swift
//  DatingMessengers
//
//  Created by MBA0051 on 11/3/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

protocol ContactsSearchedViewCellDelegate: class {
    func markContactAdd(view: ContactsSearchedViewCell, contact: ContactDomain)
    func markContactRemove(view: ContactsSearchedViewCell, id: String)
}

class ContactsSearchedViewCell: UITableViewCell {

    @IBOutlet weak var markStatusButton: UIButton!
    weak var delegate: ContactsSearchedViewCellDelegate?
    private var markStatus = false;
    var viewModel: ContactCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                // MARK: todo
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func markFriendAddedButtonClick(_ sender: UIButton) {
        if markStatus == true {
            markStatusButton.setImage(UIImage(named: "remove-button-md"), for: .normal)
            markStatus = false
            // Add image to list.
//            delegate?.markContactAdd(view: self,contact: ContactDomain(id: contactDetailViewCell.viewModel!.id, username: contactDetailViewCell.viewModel!.username, alias: contactDetailViewCell.viewModel!.aliasName, img: contactDetailViewCell.viewModel!.imgUrl))
        } else {
            markStatusButton.setImage(UIImage(named: "add-button-md"), for: .normal)
            markStatus = true
//            delegate?.markContactRemove(view: self, id: contactDetailViewCell.viewModel!.id)
        }
    }
}
