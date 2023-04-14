//
//  SignUpViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/21/23.
//

import XCTest
@testable import TalkTime


final class SignUpViewModelTests: XCTestCase {

    var firebaseAuthManager: MockFirebaseAuthenticationManager!
    var firebaseDBManager: MockFirebaseDatabaseManager!
    var vc: UIViewController!
    var viewModel: SignUpViewModel!
    
    override func setUpWithError() throws {
        firebaseAuthManager = MockFirebaseAuthenticationManager()
        firebaseDBManager = MockFirebaseDatabaseManager()
        vc = UIViewController()
        viewModel = SignUpViewModel(firebaseAuthManager: firebaseAuthManager, firebaseDBManager: firebaseDBManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseAuthManager = nil
        firebaseDBManager = nil
        vc = nil
        viewModel = nil
    }
    
    func testCreateUserSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        firebaseDBManager.successfulAPICall = true
        viewModel.signUp(provider: Constants.Provider.undefined, email: "test@test.com",
                             firstName: "Talor", lastName: "Levy", phone: "3334445555",
                             dateOfBirth: Date(), gender: Constants.Gender.undefined,
                             password: "password") { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testCreateUserFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        firebaseDBManager.successfulAPICall = false
        viewModel.signUp(provider: Constants.Provider.undefined, email: "test@test.com",
                             firstName: "Talor", lastName: "Levy", phone: "3334445555",
                             dateOfBirth: Date(), gender: Constants.Gender.undefined,
                             password: "password") { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSignOutOfFirebaseSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        viewModel.signOutOfFirebase { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSignOutOfFirebaseFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        viewModel.signOutOfFirebase { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSaveUserToDatabaseSuccess() throws {
        firebaseDBManager.successfulAPICall = true
        let user = UserModel(uid: "testuid", provider: Constants.Provider.undefined,
                             email: "test@test.com")
        viewModel.saveUserToDatabase(uid: user.uid, userModel: user) { result in
            switch result {
            case .success():
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSaveUserToDatabaseFailure() throws {
        firebaseDBManager.successfulAPICall = false
        let user = UserModel(uid: "testuid", provider: Constants.Provider.undefined,
                             email: "test@test.com")
        viewModel.saveUserToDatabase(uid: user.uid, userModel: user) { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
