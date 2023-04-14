//
//  ProfileViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/22/23.
//

import XCTest
@testable import TalkTime


final class ProfileViewModelTests: XCTestCase {

    var firebaseDBManager: MockFirebaseDatabaseManager!
    var firebaseStoreManager: MockFirebaseStorageManager!
    var vc: UIViewController!
    var viewModel: DeleteEditProfileViewModel!
    
    override func setUpWithError() throws {
        firebaseDBManager = MockFirebaseDatabaseManager()
        firebaseStoreManager = MockFirebaseStorageManager()
        vc = UIViewController()
        viewModel = DeleteEditProfileViewModel(firebaseDBManager: firebaseDBManager, firebaseStoreManager: firebaseStoreManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseDBManager = nil
        firebaseStoreManager = nil
        vc = nil
        viewModel = nil
    }
    
    func testUpdateUserSuccess() throws {
        firebaseDBManager.successfulAPICall = true
        firebaseStoreManager.successfulAPICall = true
        let image = Data()
        let userDictionary: [String: Any] = ["first_name": "John", "last_name": "Smith",
                                             "phone": "3334445555", "gender": "undefined",
                                             "date_of_birth": "03-01-2023"]
        LocalData.shared.currentUser = UserModel(uid: "1", provider: Constants.Provider.undefined, email: "test@test.com")
        viewModel.updateUser(uid: "1", image: image, userDictionary: userDictionary) { result in
            switch result {
            case .success():
                XCTAssertEqual(LocalData.shared.currentUser?.firstName, "John")
                
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testUpdateUserFailure() throws {
        firebaseDBManager.successfulAPICall = false
        firebaseStoreManager.successfulAPICall = false
        let image = Data()
        let userDictionary = ["first_name": "John", "last_name": "Smith", "phone": "3334445555",
                          "gender": "undefined", "date_of_birth": "03-01-2023"]
        LocalData.shared.currentUser = UserModel(uid: "1", provider: Constants.Provider.undefined, email: "test@test.com")
        viewModel.updateUser(uid: "1", image: image, userDictionary: userDictionary) { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testSaveProfilePictureSuccess() throws {
        firebaseStoreManager.successfulAPICall = true
        let image = Data()
        viewModel.saveProfilePicture(uid: "1", image: image) { result in
            switch result {
            case .success(let url):
                let strUrl = url.absoluteString
                XCTAssertEqual(strUrl, "https://www.google.com")
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSaveProfilePictureFailure() throws {
        firebaseStoreManager.successfulAPICall = false
        let image = Data()
        viewModel.saveProfilePicture(uid: "1", image: image) { result in
            switch result {
            case .success(_):
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
