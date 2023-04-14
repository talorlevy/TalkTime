//
//  MainTabBarViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/18/23.
//

import UIKit


class MainTabBarViewModel {
        
    let firebaseDBManager: FirebaseDatabaseService
    let firebaseStoreManager: FirebaseStorageService
    let vc: UIViewController

    init(firebaseDBManager: FirebaseDatabaseService, firebaseStoreManager: FirebaseStorageService,
         vc: UIViewController) {
        self.firebaseDBManager = firebaseDBManager
        self.firebaseStoreManager = firebaseStoreManager
        self.vc = vc
    }
}
