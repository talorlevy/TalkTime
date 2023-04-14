//
//  LocalUser.swift
//  TalkTime
//
//  Created by Talor Levy on 3/8/23.
//

import Foundation


class LocalData {

    var currentUser: UserModel?

    static let shared = LocalData()
    let firebaseDBManager: FirebaseDatabaseService
    
    private init() {
        self.firebaseDBManager = FirebaseDatabaseManager.shared
    }
}
