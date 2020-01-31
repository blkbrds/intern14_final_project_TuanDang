//
//  ContactViewCellDelegate.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

class ContactViewCell: UITableViewCell {

    @IBOutlet weak var aliasNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var viewModel: ContactCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                aliasNameLabel.text = viewModel.aliasName
                usernameLabel.text = viewModel.username
                avatarImageView.dowloadFromServer(link: viewModel.imgUrl, contentMode: .scaleAspectFill)
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
}
