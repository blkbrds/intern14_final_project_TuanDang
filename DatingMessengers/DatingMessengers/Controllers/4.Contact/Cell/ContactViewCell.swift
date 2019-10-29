//
//  ContactViewCellDelegate.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

protocol ContactViewCellDelegate: class {
    func tapButtonClick(view: ContactViewCell)
}

class ContactViewCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    var indexPath: IndexPath?
    weak var delegate: ContactViewCellDelegate?
    
    var viewModel: ContactCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func tapMeButtonClick(_ sender: UIButton) {
        delegate?.tapButtonClick(view: self)
    }
}
