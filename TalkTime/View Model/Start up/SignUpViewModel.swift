//
//  SignUpViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import FirebaseAuth
import UIKit

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

    func signUp(provider: Constants.Provider,
                email: String,
                username: String,
                firstName: String,
                lastName: String,
                phone: String,
                dateOfBirth: Date,
                gender: Constants.Gender,
                password: String,
                completion: @escaping(Result<Bool, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.firebaseDBManager.checkIfUsernameExists(username: username) { result in
                switch result {
                case .success(let exists):
                    if exists {
                        completion(.success(exists))
                    } else {
                        self?.firebaseAuthManager.createUser(email: email, password: password) { result in
                            switch result {
                            case .success(let user):
                                guard let user = user else { return }
                                let userModel = UserModel(uid: user.uid,
                                                          provider: provider,
                                                          email: email,
                                                          username: username,
                                                          firstName: firstName,
                                                          lastName: lastName,
                                                          phone: phone,
                                                          dateOfBirth: dateOfBirth,
                                                          gender: gender)
                                let userDictionary = Formatting.userToDictionary(userModel: userModel)
                                self?.firebaseDBManager.createUser(uid: user.uid,
                                                                  userDictionary: userDictionary) { result in
                                    switch result {
                                    case .success():
                                        self?.firebaseAuthManager.signOutOfFirebase { result in
                                            DispatchQueue.main.async {
                                                switch result {
                                                case .success():
                                                    completion(.success(exists))
                                                case .failure(let error):
                                                    completion(.failure(error))
                                                }
                                            }
                                        }
                                    case .failure(let error):
                                        DispatchQueue.main.async {
                                            completion(.failure(error))
                                        }
                                    }
                                }
                            case .failure(let error):
                                DispatchQueue.main.async {
                                    completion(.failure(error))
                                }
                            }
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}

