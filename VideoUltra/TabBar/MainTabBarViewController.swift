//
//  MainTabBarViewController.swift
//  VideoUltra
//
//  Created by Nikita Galaganov on 19/03/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        setTabBarLook()
    }
    
    private func setTabBarLook() {
        tabBar.isTranslucent = false
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }

    // Delegate method
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
