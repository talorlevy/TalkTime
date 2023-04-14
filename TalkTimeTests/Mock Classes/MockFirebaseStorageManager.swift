//
//  MockFirebaseStorageManager.swift
//  TalkTimeTests
//
//  Created by Talor Levy on 3/21/23.
//

import Foundation
@testable import TalkTime


class MockFirebaseStorageManager: FirebaseStorageService {
    
    var successfulAPICall: Bool = false
    
    func saveProfilePicture(uid: String, image: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        if successfulAPICall {
            if let url = URL(string: "https://www.google.com") {
                completion(.success(url))
            }
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
    
    func savePostImage(postUID: String, image: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        if successfulAPICall {
            if let url = URL(string: "https://www.google.com") {
                completion(.success(url))
            }
        } else {
            completion(.failure(Constants.CustomError.failedAPICall))
        }
    }
}
