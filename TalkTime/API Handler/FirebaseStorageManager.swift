//
//  FirebaseStorageManager.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 3/2/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


protocol FirebaseStorageService {
    func saveProfilePicture(uid: String, image: Data, completion: @escaping (Result<URL, Error>) -> Void)
    func savePostImage(postUID: String, image: Data, completion: @escaping (Result<URL, Error>) -> Void)
}


class FirebaseStorageManager: FirebaseStorageService {

    static let shared = FirebaseStorageManager()
    var ref: StorageReference!

    private init() {
        ref = Storage.storage().reference()
    }

    
    //MARK: - User

    func saveProfilePicture(uid: String, image: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let savedImageRef = ref.child("users/\(uid)/profile_picture")
        let profilePhotoMetadata = StorageMetadata()
        profilePhotoMetadata.contentType = "image/jpeg"
        savedImageRef.putData(image, metadata: profilePhotoMetadata) { metadata, error in
            if let error = error {
                print("Error saving profile picture at Firebase Storage")
                completion(.failure(error))
            } else {
                savedImageRef.downloadURL { downloadURL, error in
                    if let error = error {
                        print("Success saving profile picture but error getting download URL at Firebase Storage")
                        completion(.failure(error))
                    } else if let downloadURL = downloadURL {
                        print("Success saving profile picture and getting download URL at Firebase Storage")
                        completion(.success(downloadURL))
                    } else {
                        completion(.failure(NSError(domain: "Firebase Storage", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get download URL"])))
                    }
                }
            }
        }
    }
    
    
    //MARK: - Post

    func savePostImage(postUID: String, image: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let savedImageRef = ref.child("posts/\(postUID)")
        savedImageRef.putData(image) { metadata, error in
            if let error = error {
                print("Error saving post image at Firebase Storage")
                completion(.failure(error))
            } else {
                savedImageRef.downloadURL { downloadURL, error in
                    if let error = error {
                        print("Success saving post image but error getting download URL at Firebase Storage")
                        completion(.failure(error))
                    } else if let downloadURL = downloadURL {
                        print("Success saving post image and getting download URL at Firebase Storage")
                        completion(.success(downloadURL))
                    } else {
                        completion(.failure(NSError(domain: "Firebase Storage", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get download URL"])))
                    }
                }
            }
        }
    }
}
