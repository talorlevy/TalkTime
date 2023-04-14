//
//  UIViewControllerExtension.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 3/1/23.
//

import UIKit

extension UIViewController {
    
    func setRootViewController(vc: UIViewController) {
        if let windowScene = view.window?.windowScene?.delegate as? SceneDelegate,
           let window = windowScene.window {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
    
//    func setRootViewController(vc: UIViewController, editProfile: Bool) {
//        if let windowScene = view.window?.windowScene?.delegate as? SceneDelegate,
//           let window = windowScene.window {
//            window.rootViewController = vc
//            window.makeKeyAndVisible()
//        }
//    }
}
