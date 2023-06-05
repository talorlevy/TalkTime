//
//  SignInViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn


class SignInViewModel {
    
    let firebaseAuthManager: FirebaseAuthenticationService
    let firebaseDBManager: FirebaseDatabaseService
    var vc: UIViewController
    
    init(firebaseAuthManager: FirebaseAuthenticationService, firebaseDBManager: FirebaseDatabaseService, vc: UIViewController) {
        self.firebaseAuthManager = firebaseAuthManager
        self.firebaseDBManager = firebaseDBManager
        self.vc = vc
    }
    
    
    
    // MARK: - Firebase Authentication
    
    func isLoggedIn(completion: @escaping(Result<Void, Error>) -> Void) {
        if firebaseAuthManager.isLoggedIn() {
            let uid = Auth.auth().currentUser?.uid ?? ""
            firebaseDBManager.fetchUser(uid: uid) { result in
                switch result {
                case .success(let user):
                    print("Success fetching user at SignInViewModel")
                    LocalData.shared.currentUser = user
                    completion(.success(()))
                case .failure(let error):
                    print("Error fetching user at SignInViewModel: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        } else {
            print("User is not logged in at SignInViewModel")
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        firebaseAuthManager.signInWithEmail(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                let uid = Auth.auth().currentUser?.uid ?? ""
                self.firebaseDBManager.fetchUser(uid: uid) { result in
                    switch result {
                    case .success(let user):
                        print("Success fetching user at SignInViewModel")
                        LocalData.shared.currentUser = user
                        completion(.success(()))
                    case .failure(let error):
                        print("Error fetching user at SignInViewModel")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Error fetching user at SignInViewModel")
                completion(.failure(error))
            }
        }
    }
    
    func signInWithGoogle(completion: @escaping(Result<Void, Error>) -> Void) {
        firebaseAuthManager.signInWithGoogle(vc: vc) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let isNewUser):
                print("Success signing in to Google at SignInViewModel")
                if isNewUser {
                    self.firebaseDBManager.getAllUsernames { result in
                        switch result {
                        case .success(let existingUsernames):
                            print("Success fetching all usernames at SignInViewModel")
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
                                        print("Success creating user at SignInViewModel")
                                        completion(.success(()))
                                    case .failure(let error):
                                        print("Error creating user at SignInViewModel")
                                        completion(.failure(error))
                                    }
                                }
                            }
                        case .failure(let error):
                            print("Error fetching all usernames at SignInViewModel")
                            completion(.failure(error))
                        }
                    }
                } else {
                    let uid = Auth.auth().currentUser?.uid ?? ""
                    self.firebaseDBManager.fetchUser(uid: uid) { result in
                        switch result {
                        case .success(let user):
                            print("Success fetching user at SignInViewModel")
                            LocalData.shared.currentUser = user
                            completion(.success(()))
                        case .failure(let error):
                            print("Error fetching user at SignInViewModel")
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                print("Error fetching user at SignInViewModel")
                completion(.failure(error))
            }
        }
    }
    
    
    
    func signInWithFacebook(completion: @escaping(Result<Void, Error>) -> Void) {
        firebaseAuthManager.signInWithFacebook(vc: vc) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let isNewUser):
                print("Success signing in to Facebook at SignInViewModel")
                if isNewUser {
                    self.firebaseDBManager.getAllUsernames { result in
                        switch result {
                        case .success(let existingUsernames):
                            print("Success fetching all usernames at SignInViewModel")
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
                                        print("Success creating user at SignInViewModel")
                                        completion(.success(()))
                                    case .failure(let error):
                                        print("Error creating user at SignInViewModel")
                                        completion(.failure(error))
                                    }
                                }
                            }
                        case .failure(let error):
                            print("Error fetching all usernames at SignInViewModel")
                            completion(.failure(error))
                        }
                    }
                } else {
                    let uid = Auth.auth().currentUser?.uid ?? ""
                    self.firebaseDBManager.fetchUser(uid: uid) { result in
                        switch result {
                        case .success(let user):
                            print("Success fetching user at SignInViewModel")
                            LocalData.shared.currentUser = user
                            completion(.success(()))
                        case .failure(let error):
                            print("Error fetching user at SignInViewModel")
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                print("Error fetching user at SignInViewModel")
                completion(.failure(error))
            }
        }
    }
}
