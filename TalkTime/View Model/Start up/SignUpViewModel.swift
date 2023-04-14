//
//  SignUpViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit
import FirebaseAuth


class SignUpViewModel {
        
    let firebaseAuthManager: FirebaseAuthenticationService
    let firebaseDBManager: FirebaseDatabaseService
    let vc: UIViewController

    init(firebaseAuthManager: FirebaseAuthenticationService, firebaseDBManager: FirebaseDatabaseService, vc: UIViewController) {
        self.firebaseAuthManager = firebaseAuthManager
        self.firebaseDBManager = firebaseDBManager
        self.vc = vc
    }
    
    
    // MARK: - Sign Up (check username, create account, create user in database, sign out)

    func signUp(provider: Constants.Provider, email: String, username: String, firstName: String,
                lastName: String, phone: String, dateOfBirth: Date, gender: Constants.Gender,
                password: String, completion: @escaping(Result<Bool, Error>) -> Void) {
        firebaseDBManager.checkIfUsernameExists(username: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let exists):
                print("Success checking if username exists at SignUpViewModel")
                if exists {
                    completion(.success(exists))
                } else {
                    self.firebaseAuthManager.createUser(email: email, password: password) { result in
                        switch result {
                        case .success(let user):
                            print("Success creating authentication account at SignUpViewModel")
                            guard let user = user else { return }
                            let userModel = UserModel(uid: user.uid, provider: provider, email: email,
                                                      username: username, firstName: firstName, lastName: lastName,
                                                      phone: phone, dateOfBirth: dateOfBirth, gender: gender)
                            let userDictionary = Formatting.userToDictionary(userModel: userModel)
                            self.firebaseDBManager.createUser(uid: user.uid, userDictionary: userDictionary) { result in
                                switch result {
                                case .success():
                                    print("Success creating user at SignUpViewModel")
                                    self.firebaseAuthManager.signOutOfFirebase { result in
                                        switch result {
                                        case .success():
                                            print("Success signing out of Firebase at SignUpViewModel")
                                            completion(.success(exists))
                                        case .failure(let error):
                                            print("Error signing out of Firebase at SignUpViewModel: \(error.localizedDescription)")
                                            completion(.failure(error))
                                        }
                                    }
                                case .failure(let error):
                                    print("Error creating user at SignUpViewModel")
                                    completion(.failure(error))
                                }
                            }
                        case .failure(let error):
                            print("Error creating authentication account at SignUpViewModel")
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                print("Error checking if username exists at SignUpViewModel")
                completion(.failure(error))
            }
        }
    }
}

