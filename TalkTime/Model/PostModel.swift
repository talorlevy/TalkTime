//
//  PostModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import Foundation


struct PostModel {
    var postUID: String?
    var userUID: String
    var username: String
    var uploadTime: Date
    var imageUrl: URL?
    var description: String?
    var userProfilePictureUrl: URL?
    var likes: Int?
    var bookmarks: Int?
    var comments: [CommentModel]?
}

struct CommentModel {
    var userUID: String
    var description: String
    var creationTime: Date
}
