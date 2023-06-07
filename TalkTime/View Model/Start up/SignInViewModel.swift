//
//  SignInViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import FirebaseAuth
import GoogleSignIn
import UIKit

class SignInViewModel {
    
    let firebaseAuthManager: FirebaseAuthenticationService
    let firebaseDBManager: FirebaseDatabaseService
    let vc: UIViewController
    
    init(firebaseAuthManager: FirebaseAuthenticationService, firebaseDBManager: FirebaseDatabaseService, vc: UIViewController) {
        self.firebaseAuthManager = firebaseAuthManager
        self.firebaseDBManager = firebaseDBManager
        self.vc = vc
    }
    
    // MARK: - Firebase Authentication
    
    func isLoggedIn(completion: @escaping(Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self = self else { return }
            if self.firebaseAuthManager.isLoggedIn() {
                let uid = Auth.auth().currentUser?.uid ?? ""
                self.firebaseDBManager.fetchUser(uid: uid) { result in
                    switch result {
                    case .success(let user):
                        LocalData.shared.currentUser = user
                        DispatchQueue.main.async {
                            completion(.success(()))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else {
                print("User is not logged in at SignInViewModel")
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.firebaseAuthManager.signInWithEmail(email: email, password: password) { result in
                guard let self = self else { return }
                switch result {
                case .success():
                    let uid = Auth.auth().currentUser?.uid ?? ""
                    self.firebaseDBManager.fetchUser(uid: uid) { result in
                        switch result {
                        case .success(let user):
                            LocalData.shared.currentUser = user
                            DispatchQueue.main.async {
                                completion(.success(()))
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
    }
    
    func signInWithGoogle(completion: @escaping(Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.firebaseAuthManager.signInWithGoogle(vc: self.vc) { result in
                switch result {
                case .success(let isNewUser):
                    if isNewUser {
                        self.firebaseDBManager.getAllUsernames { result in
                            switch result {
                            case .success(let existingUsernames):
                                var foundUniqueUsername: Bool = false
                                var uniqueUsername: String = Generator.generateUsername()
                                while foundUniqueUsername == false {
                                    if !existingUsernames.contains(uniqueUsername) {
                                        foundUniqueUsername = true
                                    } else {
                                        uniqueUsername = Generator.generateUsername()
                                    }
                                }
                                if let currentUser = Auth.auth().currentUser {
                                    let uid = currentUser.uid
                                    let email = currentUser.email ?? ""
                                    let username = uniqueUsername
                                    let provider = "google.com"
                                    let dictionary = ["uid": uid, "email": email, "provider": provider, "username": username]
                                    self.firebaseDBManager.createUser(uid: uid, userDictionary: dictionary) { result in
                                        switch result {
                                        case .success():
                                            DispatchQueue.main.async {
                                                completion(.success(()))
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
                    } else {
                        let uid = Auth.auth().currentUser?.uid ?? ""
                        self.firebaseDBManager.fetchUser(uid: uid) { result in
                            switch result {
                            case .success(let user):
                                LocalData.shared.currentUser = user
                                DispatchQueue.main.async {
                                    completion(.success(()))
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
    
    func signInWithFacebook(completion: @escaping(Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.firebaseAuthManager.signInWithFacebook(vc: self.vc) { result in
                switch result {
                case .success(let isNewUser):
                    if isNewUser {
                        self.firebaseDBManager.getAllUsernames { result in
                            switch result {
                            case .success(let existingUsernames):
                                var foundUniqueUsername: Bool = false
                                var uniqueUsername: String = Generator.generateUsername()
                                while foundUniqueUsername == false {
                                    if !existingUsernames.contains(uniqueUsername) {
                                        foundUniqueUsername = true
                                    } else {
                                        uniqueUsername = Generator.generateUsername()
                                    }
                                }
                                if let currentUser = Auth.auth().currentUser {
                                    let uid = currentUser.uid
                                    let email = currentUser.email ?? ""
                                    let username = uniqueUsername
                                    let provider = "facebook.com"
                                    let dictionary = ["uid": uid, "email": email, "provider": provider, "username": username]
                                    self.firebaseDBManager.createUser(uid: uid, userDictionary: dictionary) { result in
                                        switch result {
                                        case .success():
                                            DispatchQueue.main.async {
                                                completion(.success(()))
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
                    } else {
                        let uid = Auth.auth().currentUser?.uid ?? ""
                        self.firebaseDBManager.fetchUser(uid: uid) { result in
                            switch result {
                            case .success(let user):
                                LocalData.shared.currentUser = user
                                DispatchQueue.main.async {
                                    completion(.success(()))
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
