//
//  TableCell.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }

    private func configView() {
        textLabel?.font = App.Font.tableCellTextLabel
        textLabel?.textColor = App.Color.tableCellTextLabel
        detailTextLabel?.font = App.Font.tableCellTextLabel
        detailTextLabel?.textColor = App.Color.tableCellTextLabel
    }
}
