//
//  MainTabBarViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/22/23.
//

import XCTest
@testable import TalkTime


final class MainTabBarViewModelTests: XCTestCase {

    var firebaseDBManager: MockFirebaseDatabaseManager!
    var firebaseStoreManager: MockFirebaseStorageManager!
    var vc: UIViewController!
    var viewModel: MainTabBarViewModel!
    
    override func setUpWithError() throws {
        firebaseDBManager = MockFirebaseDatabaseManager()
        firebaseStoreManager = MockFirebaseStorageManager()
        vc = UIViewController()
        viewModel = MainTabBarViewModel(firebaseDBManager: firebaseDBManager, firebaseStoreManager: firebaseStoreManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseDBManager = nil
        firebaseStoreManager = nil
        vc = nil
        viewModel = nil
    }

    func testFetchAllPostsSuccess() throws {
        firebaseDBManager.successfulAPICall = true
        firebaseStoreManager.successfulAPICall = true
        viewModel.fetchAllPosts { result in
            switch result {
            case .success():
                XCTAssertEqual(LocalData.shared.posts?.count, 1)
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testFetchAllPostsFailure() throws {
        firebaseDBManager.successfulAPICall = false
        firebaseStoreManager.successfulAPICall = false
        viewModel.fetchAllPosts { result in
            switch result {
            case .success():
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
