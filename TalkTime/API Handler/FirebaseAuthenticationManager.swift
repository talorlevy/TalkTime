//
//  FirebaseManager.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 2/28/23.
//

import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FacebookLogin


protocol FirebaseAuthenticationService {
    func isLoggedIn() -> Bool
    func createUser(email: String, password: String, completion: @escaping(Result<User?, Error>) -> Void)
    func signInWithEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void)
    func signInWithGoogle(vc: UIViewController, completion: @escaping(Result<Bool, Error>) -> Void)
    func signInWithFacebook(vc: UIViewController, completion: @escaping(Result<Bool, Error>) -> Void)
    func signOut(completion: @escaping(Result<Void, Error>) -> Void)
    func signOutOfFirebase(completion: @escaping(Result<Void, Error>) -> Void)
    func signOutOfGoogle(completion: @escaping(Result<Void, Error>) -> Void)
    func signOutOfFacebook(completion: @escaping(Result<Void, Error>) -> Void)
}


class FirebaseAuthenticationManager: FirebaseAuthenticationService {
    
    static let shared = FirebaseAuthenticationManager()
    var loginManager: LoginManager?

    private init() {
        loginManager = LoginManager()
    }

    
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
            return true
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping(Result<User?, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error creating auth user at Firebase Authentication Manager")
                completion(.failure(error))
            }
            if let authResult = authResult {
                print("Success creating auth user at Firebase Authentication Manager")
                completion(.success(authResult.user))
            }
        }
    }
    
    func signInWithEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let _ = self else { return }
            if let error = error {
                print("Error signing in via email/password at Firebase Authentication Manager")
                completion(.failure(error))
            }
            if let _ = authResult {
                print("Success signing in via email/password at Firebase Authentication Manager")
                completion(.success(()))
            }
        }
    }
    
    func signInWithGoogle(vc: UIViewController, completion: @escaping(Result<Bool, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { user, error in
            if let error = error {
                print("Error signing in with Google at Firebase Authentication Manager")
                completion(.failure(error))
            }
            let credential = GoogleAuthProvider.credential(withIDToken: user?.user.idToken?.tokenString ?? "", accessToken: user?.user.accessToken.tokenString ?? "")
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error authenticating into Firebase with Google at Firebase Authentication Manager")
                    completion(.failure(error))
                }
                if let authResult = authResult {
                    print("Success authenticating into Firebase with Google at Firebase Authentication Manager")
                    if authResult.additionalUserInfo?.isNewUser == true {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                }
            }
        }
    }
        
    func signInWithFacebook(vc: UIViewController, completion: @escaping(Result<Bool, Error>) -> Void) {
        loginManager?.logIn(permissions: ["public_profile","email", "user_friends"], from: vc) { _, error in
            GraphRequest(graphPath: "me", parameters: ["fields": "id,name,email,first_name,last_name"])
            .start { connection, result, error in
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("Error authenticating into Firebase with Facebook at FirebaseAuthenticationManager")
                        completion(.failure(error))
                    }
                    if let authResult = authResult {
                        print("Success authenticating into Firebase with Facebook at FirebaseAuthenticationManager")
                        if authResult.additionalUserInfo?.isNewUser == true {
                            completion(.success(true))
                        } else {
                            completion(.success(false))
                        }
                    }
                }
            }
        }
    }
    
    func signOut(completion: @escaping(Result<Void, Error>) -> Void) {
        if let user = Auth.auth().currentUser {
            for info in user.providerData {
                if info.providerID == "google.com" {
                    print("User is signed in with google, attempting sign out")
                    signOutOfGoogle { result in
                        switch result {
                        case .success():
                            print("Success signing out of Google at FirebaseAuthenticationManager")
                        case .failure(let error):
                            print("Error signing out of Google at FirebaseAuthenticationManager")
                            completion(.failure(error))
                        }
                    }
                }
                if info.providerID == "facebook.com" {
                    print("User is signed in with facebook, attempting sign out")
                    signOutOfFacebook { result in
                        switch result {
                        case .success():
                            print("Success signing out of Facebook at FirebaseAuthenticationManager")
                        case .failure(let error):
                            print("Error signing out of Facebook at FirebaseAuthenticationManager")
                            completion(.failure(error))
                        }
                    }
                }
            }
            signOutOfFirebase { result in
                switch result {
                case .success():
                    print("Success signing out of FirebaseAuthenticationManager")
                    completion(.success(()))
                case .failure(let error):
                    print("Error signing out of FirebaseAuthenticationManager")
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signOutOfGoogle(completion: @escaping(Result<Void, Error>) -> Void) {
        GIDSignIn.sharedInstance.signOut()
        if GIDSignIn.sharedInstance.currentUser == nil {
            print("Success signing out of Google at FirebaseAuthenticationManager")
            completion(.success(()))
        } else {
            print("Error signing out of Google at FirebaseAuthenticationManager")
            completion(.failure(Constants.CustomError.signOut))
        }
    }

    func signOutOfFacebook(completion: @escaping(Result<Void, Error>) -> Void) {
        loginManager?.logOut()
        if AccessToken.current == nil {
            print("Success signing out of Facebook at FirebaseAuthenticationManager")
            completion(.success(()))
        } else {
            print("Error signing out of Facebook at FirebaseAuthenticationManager")
            completion(.failure(Constants.CustomError.signOut))
        }
    }
    
    func signOutOfFirebase(completion: @escaping(Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            print("Success signing out of Firebase at FirebaseAuthenticationManager")
            completion(.success(()))
        } catch let error as NSError {
            print("Error signing out of Firebase account at FirebaseAuthenticationManager")
            completion(.failure(error))
        }
    }
}




//let uid = authResult.user.uid
//let email = authResult.user.email ?? ""
//let provider = "facebook.com"
//let dictionary = ["uid": uid, "email": email, "provider": provider]
//FirebaseDatabaseManager.shared.createUser(uid: uid, userDictionary: dictionary) { result in
//    switch result {
//    case .success():
//        print("Success creating user at FirebaseAuthenticationManager")
//    case .failure(let error):
//        print("Error creating user at FirebaseAuthenticationManager")
//        completion(.failure(error))
//    }
