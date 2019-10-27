//
//  TabbarViewController.swift
//  DatingMessenger
//
//  Created by MBA0051 on 10/22/19.
//  Copyright © 2019 MBA0051. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let messagesViewController = MessagesViewController()
        let messageNavi = UINavigationController(rootViewController: messagesViewController)
        messageNavi.tabBarItem = UITabBarItem(title: "Message home", image: UIImage(named: "favorite_selected" )!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "favorite"))
        
        let contactsViewController = ContactsViewController()
        let contactNavi = UINavigationController(rootViewController: contactsViewController)
        contactNavi.tabBarItem = UITabBarItem(title: "Contact home", image: UIImage(named: "home_selected" )!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "home"))

        let schedulesViewController = SchedulesViewController()
        let scheduleNavi = UINavigationController(rootViewController: schedulesViewController)
        scheduleNavi.tabBarItem = UITabBarItem(title: "Schedule home", image: UIImage(named: "map_selected" )!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "map"))
        
        let personalViewController = PersonalViewController()
        let personalNavi = UINavigationController(rootViewController: personalViewController)
        personalNavi.tabBarItem = UITabBarItem(title: "Personally page", image: UIImage(named: "profile_selected" )!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "profile"))

        viewControllers = [messageNavi, contactNavi, scheduleNavi, personalNavi]
    }
}
