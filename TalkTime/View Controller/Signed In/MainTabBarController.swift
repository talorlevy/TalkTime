//
//  ViewController.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 2/28/23.
//

import UIKit


class MainTabBarController: UITabBarController {

    var viewModel: MainTabBarViewModel?

    
    //MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        localizeTabBar()
        setViewControllerDelegate()
//        pushEditProfileViewController()
    }

    
    //MARK: - functions
    
    func initializeViewModel() {
        viewModel = MainTabBarViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, firebaseStoreManager: FirebaseStorageManager.shared, vc: self)
    }
    
    func localizeTabBar() {
        guard let tabBarItems = tabBar.items else { return }
        tabBarItems[0].title = MainTabBarControllerString.homeTab.localized.firstUppercased
        tabBarItems[1].title = MainTabBarControllerString.messageTab.localized.firstUppercased
        tabBarItems[2].title = MainTabBarControllerString.postTab.localized.firstUppercased
        tabBarItems[3].title = MainTabBarControllerString.searchTab.localized.firstUppercased
        tabBarItems[4].title = MainTabBarControllerString.settingsTab.localized.firstUppercased
    }
  
    func setViewControllerDelegate() {
        if let homeVC = viewControllers?[0] as? HomeViewController,
           let postVC = viewControllers?[2] as? PostViewController {
            postVC.delegate = homeVC
        }
    }
    
//    func pushEditProfileViewController() {
//        if let navigationController = viewControllers?[4] as? UINavigationController {
//            let editProfileViewController = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
//            navigationController.pushViewController(editProfileViewController, animated: true)
//        }
//    }
}
