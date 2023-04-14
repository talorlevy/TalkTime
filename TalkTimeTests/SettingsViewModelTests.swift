//
//  SettingsViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/22/23.
//

import XCTest
@testable import TalkTime


final class SettingsViewModelTests: XCTestCase {

    var firebaseAuthManager: MockFirebaseAuthenticationManager!
    var vc: UIViewController!
    var viewModel: SettingsViewModel!
    
    override func setUpWithError() throws {
        firebaseAuthManager = MockFirebaseAuthenticationManager()
        vc = UIViewController()
        viewModel = SettingsViewModel(firebaseAuthManager: firebaseAuthManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseAuthManager = nil
        vc = nil
        viewModel = nil
    }
    
    func testSignOutSuccess() throws {
        firebaseAuthManager.successfulAPICall = true
        LocalData.shared.currentUser = UserModel(uid: "1", provider: Constants.Provider.undefined,
                                          email: "test@test.com")
        viewModel.signOut { result in
            switch result {
            case .success():
                XCTAssertNil(LocalData.shared.currentUser)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSignOutFailure() throws {
        firebaseAuthManager.successfulAPICall = false
        LocalData.shared.currentUser = UserModel(uid: "1", provider: Constants.Provider.undefined,
                                          email: "test@test.com")
        viewModel.signOut { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
