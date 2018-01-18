//
//  TabBarController.swift
//  HorizontalCollectionView
//
//  Created by Nuno Pereira on 18/01/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let keypadViewController = setupTemplateViewController(unselectedImage: #imageLiteral(resourceName: "keypad-unselected"), selectedImage: #imageLiteral(resourceName: "keypad"), title: "Keypad", rootViewController: KeypadViewController())
        let contactsViewController = setupTemplateViewController(unselectedImage: #imageLiteral(resourceName: "agenda-unselected"), selectedImage: #imageLiteral(resourceName: "agenda"), title: "Contacts",rootViewController: ContactsViewController())
        
        tabBar.tintColor = .black
        viewControllers = [keypadViewController, contactsViewController]
    }
    
    fileprivate func setupTemplateViewController(unselectedImage: UIImage, selectedImage: UIImage, title: String, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.title = title
        return navController
    }
}
