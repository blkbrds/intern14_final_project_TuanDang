//
//  UIViewControllerExt.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit
import SwiftUtils

extension UIViewController {
    func alert(error: Error) {
        alert(title: "ERROR", msg: error.localizedDescription, buttons: ["OK"], handler: nil)
    }

    func alert(title: String? = nil, msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .cancel, handler: { action in
                handler?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
