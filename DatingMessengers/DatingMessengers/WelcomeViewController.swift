//
//  WelcomeViewController.swift
//  DatingMessengers
//
//  Created by MBA0051 on 10/25/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Welcome page"
    }

    @IBAction func goHomeButton(_ sender: UIButton) {
        print("Welcome to my program.")
    }
}
