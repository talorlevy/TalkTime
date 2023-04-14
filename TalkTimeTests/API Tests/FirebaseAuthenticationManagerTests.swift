//
//  TalkTimeTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/20/23.
//

import XCTest
import FirebaseAuth
@testable import TalkTime


final class FirebaseAuthenticationManagerTests: XCTestCase {
    
    var firebaseAuthManager: MockFirebaseAuthenticationManager!

    override func setUpWithError() throws {
        firebaseAuthManager = MockFirebaseAuthenticationManager()
    }

    override func tearDownWithError() throws {
        firebaseAuthManager = nil
    }
    
    func testIsLoggedInSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        if firebaseAuthManager.isLoggedIn() {
            return XCTAssertTrue(true)
        } else {
            return XCTAssertTrue(false)
        }
    }
    
    func testIsLoggedInFail() throws {
        firebaseAuthManager.successfulAPICall = false
        if firebaseAuthManager.isLoggedIn() {
            return XCTAssertTrue(false)
        } else {
            return XCTAssertTrue(true)
        }
    }

    func testCreateUserSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.createUser(email: "test@test.com", password: "password") { result in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testCreateUserFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.createUser(email: "test@test.com", password: "password") { result in
            switch result {
            case .success(_):
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignInWithEmailSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.signInWithEmail(email: "test@test.com", password: "password") { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSignInWithEmailFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.signInWithEmail(email: "test@test.com", password: "password") { result in
            switch result {
            case .success():
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignInWithGoogleSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.signInWithGoogle(vc: firebaseAuthManager.vc) { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSignInWithGoogleFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.signInWithGoogle(vc: firebaseAuthManager.vc) { result in
            switch result {
            case .success():
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignInWithFacebookSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.signInWithFacebook(vc: firebaseAuthManager.vc) { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSignInWithFacebookFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.signInWithFacebook(vc: firebaseAuthManager.vc) { result in
            switch result {
            case .success():
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignOutOfFirebaseSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.signOutOfFirebase { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSignOutOfFirebaseFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.signOutOfFirebase { result in
            switch result {
            case .success():
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignOutOfGoogleSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.signOutOfGoogle { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSignOutOfGoogleFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.signOutOfGoogle { result in
            switch result {
            case .success():
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignOutOfFacebookSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseAuthManager.signOutOfFacebook { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
        }
    }
    
    func testSignOutOfFacebookFail() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseAuthManager.signOutOfFacebook { result in
            switch result {
            case .success():
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
