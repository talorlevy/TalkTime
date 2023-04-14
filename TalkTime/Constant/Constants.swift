//
//  Constants.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 2/28/23.
//

import Foundation


struct Constants {
    
    enum Gender: String {
        case male = "Male"
        case female = "Female"
        case undefined = "Undefined"
    }
    
    enum CustomError: Error {
        case signOut
        case failedDownload
        case failedAPICall
        case undefined
    }
    
    enum Provider: String {
        case email = "password"
        case google = "google.com"
        case facebook = "facebook.com"
        case undefined = "undefined"
    }

    static let testComments: [CommentModel] = {
        var comments: [CommentModel] = []
        for i in 1...10 {
            let userUID = UUID().uuidString
            let description = "Test Comment \(i)"
            let creationTime = Date().addingTimeInterval(Double(i))
            
            let comment = CommentModel(userUID: userUID, description: description, creationTime: creationTime)
            comments.append(comment)
        }
        return comments
    }()
}
