//
//  Button.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }

    private func configView() {
        titleLabel?.font = App.Font.buttonTextLabel
        for state: UIControl.State in [.normal, .highlighted, .selected, .disabled] {
            setTitleColor(App.Color.button(state: state), for: state)
        }
    }
}

