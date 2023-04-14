//
//  ProfileViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/31/23.
//

import Foundation
import UIKit


class ProfileViewModel {
    
    let firebaseAuthManager: FirebaseAuthenticationService
    let vc: UIViewController

    init(firebaseAuthManager: FirebaseAuthenticationService, vc: UIViewController) {
        self.firebaseAuthManager = firebaseAuthManager
        self.vc = vc
    }
    
    
    // MARK: - Firebase Authentication
    
    func signOut(completion: @escaping(Result<Void, Error>) -> Void) {
        firebaseAuthManager.signOut { result in
            switch result {
            case .success():
                print("Success signing out of SettingsViewModel")
                LocalData.shared.currentUser = nil
                completion(.success(()))
            case .failure(let error):
                print("Error signing out of SettingsViewModel")
                completion(.failure(error))
            }
        }
    }
}
