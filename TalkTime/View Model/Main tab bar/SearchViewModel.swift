//
//  SearchViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit


class SearchViewModel {
    
    var following: [UserModel] = []
    var followers: [UserModel] = []
    var otherUsers: [UserModel] = []
    
    let firebaseDBManager: FirebaseDatabaseService
    let firebaseStoreManager: FirebaseStorageService
    let vc: UIViewController

    init(firebaseDBManager: FirebaseDatabaseService, firebaseStoreManager: FirebaseStorageService,
         vc: UIViewController) {
        self.firebaseDBManager = firebaseDBManager
        self.firebaseStoreManager = firebaseStoreManager
        self.vc = vc
    }
    
    
    func fetchAllUsers(completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseDBManager.fetchAllUsers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                print("Success fetching all users at SearchViewModel")
                self.parseFollowersFollowingAndOtherUsers(users)
                completion(.success(()))
            case .failure(let error):
                print("Error fetching all users at SearchViewModel")
                completion(.failure(error))
            }
        }
    }
    
    func parseFollowersFollowingAndOtherUsers(_ users: [UserModel]) {
        guard let currentUser = LocalData.shared.currentUser, let followingList = currentUser.following, let followersList = currentUser.followers else { return }
        otherUsers = users
        for user in users {
            if user.uid == currentUser.uid {
                continue
            }
            for UID in followingList {
                if user.uid == UID {
                    following.append(user)
                    if let index = otherUsers.firstIndex(where: { $0.uid == UID }) {
                        otherUsers.remove(at: index)
                    }
                }
            }
            for UID in followersList {
                if user.uid == UID {
                    followers.append(user)
                    if let index = otherUsers.firstIndex(where: { $0.uid == UID }) {
                        otherUsers.remove(at: index)
                    }
                }
            }
        }
    }
}
