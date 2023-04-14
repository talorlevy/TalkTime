//
//  UserModel.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 2/28/23.
//

import Foundation

struct UserModel {
    var uid: String
    var provider: Constants.Provider
    var email: String
    var username: String
    var firstName: String?
    var lastName: String?
    var phone: String?
    var location: Location?
    var dateOfBirth: Date?
    var gender: Constants.Gender?
    var profilePictureUrl: URL?
    var bio: String?
    var following: [String]?
    var followers: [String]?
    var bookmarkedPosts: [String]?
    var likedPosts: [String]?
}

struct Location {
    var latitude: Double
    var longitude: Double
}
