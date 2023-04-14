//
//  MockFirebaseDatabaseManager.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/21/23.
//

import Foundation
@testable import TalkTime


class MockFirebaseDatabaseManager: FirebaseDatabaseService {
    
    var successfulAPICall: Bool = false
    
    func createUser(uid: String, userDictionary: [String : Any], completion: @escaping (Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func updateUser(uid: String, userDictionary: [String : Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        if successfulAPICall {
            completion(.success((userDictionary)))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func fetchUser(uid: String, completion: @escaping (Result<TalkTime.UserModel, Error>) -> Void) {
        if successfulAPICall {
            let user = UserModel(uid: uid, provider: Constants.Provider.undefined, email: "test@test.com")
            completion(.success(user))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func createPost(postDictionary: [String : Any], completion: @escaping (Result<String, Error>) -> Void) {
        if successfulAPICall {
            completion(.success("ChildAutoId"))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func updatePost(postUID: String, postDictionary: [String : Any], completion: @escaping (Result<Void, Error>) -> Void) {
        if successfulAPICall {
            completion(.success(()))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func fetchAllPosts(completion: @escaping (Result<[TalkTime.PostModel], Error>) -> Void) {
        if successfulAPICall {
            let post = PostModel(userUID: "1", uploadTime: Date())
            let postArray: [PostModel] = [post]
            completion(.success(postArray))
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
}
