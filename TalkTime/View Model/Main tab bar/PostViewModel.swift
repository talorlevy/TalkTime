//
//  PostViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit


class PostViewModel {
    
    let firebaseDBManager: FirebaseDatabaseService
    let firebaseStoreManager: FirebaseStorageService
    let vc: UIViewController

    init(firebaseDBManager: FirebaseDatabaseService,
         firebaseStoreManager: FirebaseStorageService, vc: UIViewController) {
        self.firebaseDBManager = firebaseDBManager
        self.firebaseStoreManager = firebaseStoreManager
        self.vc = vc
    }


    // MARK: - Firebase Database and Storage

    func savePost(postModel: PostModel, image: Data, completion: @escaping(Result<PostModel, Error>) -> Void) {
        let postDictionary = Formatting.postToDictionary(postModel: postModel)
        firebaseDBManager.createPost(postDictionary: postDictionary) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let postUID):
                print("Success creating post in database at PostViewModel")
                self.firebaseStoreManager.savePostImage(postUID: postUID, image: image) { result in
                    switch result {
                    case .success(let downloadURL):
                        print("Success saving post image to storage and retrieving url at PostViewModel")
                        let stringURL = downloadURL.absoluteString
                        let postUpdate = ["image_url": stringURL]
                        self.firebaseDBManager.updatePost(postUID: postUID, postDictionary: postUpdate) { result in
                            switch result {
                            case .success():
                                print("Success updating post with image url in database at PostViewModel")
                                var postModelWithImageURL = postModel
                                postModelWithImageURL.imageUrl = downloadURL
                                completion(.success(postModelWithImageURL))
                            case .failure(let error):
                                print("Error updating post with image url in database at PostViewModel")
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        print("Error saving post image to storage and retrieving url at PostViewModel")
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                print("Error creating post in database at PostViewModel")
                completion(.failure(error))
            }
        }
    }
}
