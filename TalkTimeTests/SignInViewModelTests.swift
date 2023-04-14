//
//  SignInViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/21/23.
//

import XCTest
@testable import TalkTime


final class SignInViewModelTests: XCTestCase {
    
    var firebaseAuthManager: MockFirebaseAuthenticationManager!
    var firebaseDBManager: MockFirebaseDatabaseManager!
    var vc: UIViewController!
    var viewModel: SignInViewModel!
    
    override func setUpWithError() throws {
        firebaseAuthManager = MockFirebaseAuthenticationManager()
        firebaseDBManager = MockFirebaseDatabaseManager()
        vc = UIViewController()
        viewModel = SignInViewModel(firebaseAuthManager: firebaseAuthManager, firebaseDBManager: firebaseDBManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseAuthManager = nil
        firebaseDBManager = nil
        vc = nil
        viewModel = nil
    }
    
    func testIsLoggedInSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseDBManager.successfulAPICall = true
        viewModel.isLoggedIn() { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testIsLoggedInFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseDBManager.successfulAPICall = false
        viewModel.isLoggedIn() { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignInWithEmailSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseDBManager.successfulAPICall = true
        viewModel.signInWithEmail(email: "test@test.com", password: "password") { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSignInWithEmailFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseDBManager.successfulAPICall = false
        viewModel.signInWithEmail(email: "test@test.com", password: "password") { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignInWithGoogleSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseDBManager.successfulAPICall = true
        viewModel.signInWithGoogle { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSignInWithGoogleFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseDBManager.successfulAPICall = false
        viewModel.signInWithGoogle { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignInWithFacebookSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseDBManager.successfulAPICall = true
        viewModel.signInWithFacebook { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSignInWithFacebookFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseDBManager.successfulAPICall = false
        viewModel.signInWithFacebook { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testFetchUserSuccess() throws {
        firebaseDBManager.successfulAPICall = true
        viewModel.fetchUser(uid: "123") { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.uid, "123")
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testFetchUserFailure() throws {
        firebaseDBManager.successfulAPICall = false
        viewModel.fetchUser(uid: "123") { result in
            switch result {
            case .success(_):
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
