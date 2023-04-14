//
//  GoogleMapsViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/22/23.
//

import XCTest
@testable import TalkTime


final class GoogleMapsViewModelTests: XCTestCase {

    var firebaseDBManager: MockFirebaseDatabaseManager!
    var vc: UIViewController!
    var viewModel: GoogleMapsViewModel!
    
    override func setUpWithError() throws {
        firebaseDBManager = MockFirebaseDatabaseManager()
        vc = UIViewController()
        viewModel = GoogleMapsViewModel(firebaseDBManager: firebaseDBManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseDBManager = nil
        vc = nil
        viewModel = nil
    }

    func testUpdateUserSuccess() throws {
        firebaseDBManager.successfulAPICall = true
        LocalData.shared.currentUser = UserModel(uid: "1", provider: Constants.Provider.undefined,
                                          email: "test@test.com")
        let userUpdate = ["latitude": 1.0, "longitude": 1.0]
        viewModel.updateUser(uid: "1", userDictionary: userUpdate) { result in
            switch result {
            case .success():
                XCTAssertEqual(LocalData.shared.currentUser?.location?.latitude, 1.0)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
}
