//
//  HomeViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/26/23.
//

import UIKit


class HomeViewModel {
    
    var posts: [PostModel]?

    let firebaseDBManager: FirebaseDatabaseService
    let firebaseStoreManager: FirebaseStorageService
    let vc: UIViewController

    init(firebaseDBManager: FirebaseDatabaseService, firebaseStoreManager: FirebaseStorageService,
         vc: UIViewController) {
        self.firebaseDBManager = firebaseDBManager
        self.firebaseStoreManager = firebaseStoreManager
        self.vc = vc
    }

    
    // MARK: - Posts
    
    func fetchAllPosts(completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseDBManager.fetchAllPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                print("Success fetching all posts at HomeViewModel")
                let sortedPosts = self.sortPostsByUploadTime(posts: posts)
                self.posts = sortedPosts
                completion(.success(()))
            case .failure(let error):
                print("Error fetching all posts at HomeViewModel")
                completion(.failure(error))
            }
        }
    }
    
    func sortPostsByUploadTime(posts: [PostModel]) -> [PostModel] {
        let sortedPosts = posts.sorted(by: { $0.uploadTime > $1.uploadTime })
        return sortedPosts
    }
}
