//
//  File.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/21/23.
//

import Foundation
import FirebaseAuth
import UIKit
@testable import TalkTime


class MockFirebaseAuthenticationManager: FirebaseAuthenticationService {
    
    var successfulAPICall: Bool = false
    var vc: UIViewController = UIViewController()
    
    func isLoggedIn() -> Bool {
        if successfulAPICall {
            return true
        } else {
            return false
        }
    }

    func createUser(email: String, password: String, completion: @escaping(Result<User?, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(nil))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }

    func signInWithEmail(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }

    func signInWithGoogle(vc: UIViewController, completion: @escaping(Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }

    func signInWithFacebook(vc: UIViewController, completion: @escaping(Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func signOutOfFirebase(completion: @escaping(Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }

    func signOutOfGoogle(completion: @escaping(Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }

    func signOutOfFacebook(completion: @escaping(Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
}
