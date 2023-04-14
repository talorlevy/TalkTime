//
//  PostViewModelTests.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/22/23.
//

import XCTest
@testable import TalkTime


final class PostViewModelTests: XCTestCase {

    var firebaseDBManager: MockFirebaseDatabaseManager!
    var firebaseStoreManager: MockFirebaseStorageManager!
    var vc: UIViewController!
    var viewModel: PostViewModel!
    
    override func setUpWithError() throws {
        firebaseDBManager = MockFirebaseDatabaseManager()
        firebaseStoreManager = MockFirebaseStorageManager()
        vc = UIViewController()
        viewModel = PostViewModel(firebaseDBManager: firebaseDBManager, firebaseStoreManager: firebaseStoreManager, vc: vc)
    }
    
    override func tearDownWithError() throws {
        firebaseDBManager = nil
        firebaseStoreManager = nil
        vc = nil
        viewModel = nil
    }

    func testSavePostSuccess() throws {
        firebaseDBManager.successfulAPICall = true
        firebaseStoreManager.successfulAPICall = true
        let post = PostModel(userUID: "1", uploadTime: Date())
        let image = Data()
        viewModel.savePost(postModel: post, image: image) { result in
            switch result {
            case .success(let post):
                XCTAssertEqual(LocalData.shared.posts?.count, 1)
                XCTAssertEqual(post.userUID, "1")
            case .failure(_):
                XCTFail("This is not possible")
            }
        }
    }
    
    func testSavePostFailure() throws {
        firebaseDBManager.successfulAPICall = false
        firebaseStoreManager.successfulAPICall = false
        let post = PostModel(userUID: "1", uploadTime: Date())
        let image = Data()
        viewModel.savePost(postModel: post, image: image) { result in
            switch result {
            case .success(_):
                XCTFail("This is not possible")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
