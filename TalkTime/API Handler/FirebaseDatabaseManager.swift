//
//  FirebaseDatabase.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 3/1/23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

protocol FirebaseDatabaseService {
    func checkIfUsernameExists(username: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func getAllUsernames(completion: @escaping (Result<[String], Error>) -> Void)
    func createUser(uid: String, userDictionary: [String: Any],
                    completion: @escaping(Result<Void, Error>) -> Void)
    func updateUser(uid: String, userDictionary: [String: Any],
                    completion: @escaping(Result<[String: Any], Error>) -> Void)
    func fetchUser(uid: String, completion: @escaping(Result<UserModel, Error>) -> Void)
    func fetchAllUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) // Update unit testing!
    func createPost(postDictionary: [String: Any], completion: @escaping(Result<String, Error>) -> Void)
    func updatePost(postUID: String, postDictionary: [String: Any],
                    completion: @escaping(Result<Void, Error>) -> Void)
    func fetchAllPosts(completion: @escaping (Result<[PostModel], Error>) -> Void)
}


class FirebaseDatabaseManager: FirebaseDatabaseService {
    
    static let shared = FirebaseDatabaseManager()
    var ref: DatabaseReference?
    
    private init() {
        ref = Database.database().reference()
    }
    
    
    //MARK: - User
    
    func checkIfUsernameExists(username: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let ref = Database.database().reference().child("users")
        let query = ref.queryOrdered(byChild: "username").queryEqual(toValue: username)
        query.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                print("Success checking username at FirebaseDatabaseManager")
                completion(.success(true))
            } else {
                print("Success checking username at FirebaseDatabaseManager")
                completion(.success(false))
            }
        } withCancel: { (error) in
            print("Error checking username at FirebaseDatabaseManager")
            completion(.failure(error))
        }
    }

    func getAllUsernames(completion: @escaping (Result<[String], Error>) -> Void) {
        let ref = Database.database().reference(withPath: "users")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.exists() else {
                print("No data found at 'users' path")
                completion(.success([]))
                return
            }
            var usernames: [String] = []
            for child in snapshot.children {
                if let userSnapshot = child as? DataSnapshot,
                   let username = userSnapshot.childSnapshot(forPath: "username").value as? String {
                    usernames.append(username)
                }
            }
            print("Success fetching all usernames at FirebaseDatabaseManager")
            completion(.success(usernames))
        }) { error in
            print("Error fetching all usernames at FirebaseDatabaseManager")
            completion(.failure(error))
        }
    }
    
    func createUser(uid: String, userDictionary: [String: Any],
                    completion: @escaping(Result<Void, Error>) -> Void) {
        ref?.child("users").child(uid).setValue(userDictionary) { (error: Error?, ref: DatabaseReference) in
            if let error = error {
                print("Error creating user at FirebaseDatabaseManager")
                completion(.failure(error))
            } else {
                print("Success creating user at FirebaseDatabaseManager")
                completion(.success(()))
            }
        }
    }
    
    func updateUser(uid: String, userDictionary: [String: Any],
                    completion: @escaping(Result<[String: Any], Error>) -> Void) {
        ref?.child("users").child(uid).updateChildValues(userDictionary) { (error: Error?, ref: DatabaseReference) in
            if let error = error {
                print("Error updating user at FirebaseDatabaseManager")
                completion(.failure(error))
            } else {
                print("Success updating user at FirebaseDatabaseManager")
                completion(.success((userDictionary)))
            }
        }
    }
    
    func fetchUser(uid: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        ref?.child("users/").observeSingleEvent(of: .value, with: { snapshot in
            guard let userSnapshot = snapshot.childSnapshot(forPath: uid).value as? [String: Any] else { return }
            print("Success fetching user at FirebaseDatabaseManager")
            let uid = userSnapshot["uid"] as? String ?? ""
            let email = userSnapshot["email"] as? String ?? ""
            let username = userSnapshot["username"] as? String ?? ""
            let provider = Formatting.stringToProvider(strProvider: userSnapshot["provider"] as? String ?? "")
            let firstName = userSnapshot["first_name"] as? String ?? ""
            let lastName = userSnapshot["last_name"] as? String ?? ""
            let phone = userSnapshot["phone"] as? String ?? ""
            let latitude = userSnapshot["latitude"] as? Double ?? 0
            let longitude = userSnapshot["longitude"] as? Double ?? 0
            let location = Location(latitude: latitude, longitude: longitude)
            let dateOfBirth = Formatting.stringToDate(strDate: userSnapshot["date_of_birth"] as? String ?? "")
            let gender = Formatting.stringToGender(strGender: userSnapshot["gender"] as? String ?? "")
            let profilePictureUrl = URL(string: userSnapshot["profile_picture_url"] as? String ?? "")
            let bio = userSnapshot["bio"] as? String ?? ""
            let following = userSnapshot["following"] as? [String] ?? []
            let followers = userSnapshot["followers"] as? [String] ?? []
            let bookmarkedPosts = userSnapshot["bookmarked_posts"] as? [String] ?? []
            let likedPosts = userSnapshot["liked_posts"] as? [String] ?? []
            let userModel = UserModel(uid: uid, provider: provider, email: email,
                                      username: username, firstName: firstName,
                                      lastName: lastName, phone: phone, location: location,
                                      dateOfBirth: dateOfBirth, gender: gender,
                                      profilePictureUrl: profilePictureUrl, bio: bio,
                                      following: following,followers: followers,
                                      bookmarkedPosts: bookmarkedPosts, likedPosts: likedPosts)
            completion(.success(userModel))
        }) { error in
            print("Error fetching user at FirebaseDatabaseManager")
            completion(.failure(error))
        }
    }
    
    func fetchAllUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        var users: [UserModel] = []
        ref?.child("users").observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? NSDictionary {
                for key in value.allKeys {
                    if let userDict = value[key] as? [String: Any] {
                        let uid = userDict["uid"] as? String ?? ""
                        let provider = Formatting.stringToProvider(strProvider: userDict["provider"] as? String ?? "")
                        let email = userDict["email"] as? String ?? ""
                        let username = userDict["username"] as? String ?? ""
                        let firstName = userDict["first_name"] as? String ?? ""
                        let lastName = userDict["last_name"] as? String ?? ""
                        let phone = userDict["phone"] as? String ?? ""
                        let latitude = userDict["latitude"] as? Double ?? 0
                        let longitude = userDict["longitude"] as? Double ?? 0
                        let location = Location(latitude: latitude, longitude: longitude)
                        let dateOfBirth = Formatting.stringToDate(strDate: userDict["date_of_birth"] as? String ?? "")
                        let gender = Formatting.stringToGender(strGender: userDict["gender"] as? String ?? "")
                        let profilePictureUrl = URL(string: userDict["profile_picture_url"] as? String ?? "")
                        let bio = userDict["bio"] as? String ?? ""
                        let following = userDict["following"] as? [String] ?? []
                        let followers = userDict["followers"] as? [String] ?? []
                        let bookmarkedPosts = userDict["bookmarked_posts"] as? [String] ?? []
                        let likedPosts = userDict["liked_posts"] as? [String] ?? []
                        let userModel = UserModel(uid: uid, provider: provider, email: email,
                                                  username: username, firstName: firstName,
                                                  lastName: lastName, phone: phone, location: location,
                                                  dateOfBirth: dateOfBirth, gender: gender,
                                                  profilePictureUrl: profilePictureUrl, bio: bio,
                                                  following: following,followers: followers,
                                                  bookmarkedPosts: bookmarkedPosts,
                                                  likedPosts: likedPosts)
                        users.append(userModel)
                    }
                }
                print("Success fetching all users at FirebaseDatabaseManager")
                completion(.success(users))
            } else {
                print("Error fetching all users at FirebaseDatabaseManager")
                let error = NSError(domain: "Error getting posts", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }) { error in
            completion(.failure(error))
        }
    }

    
    //MARK: - Post
    
    func createPost(postDictionary: [String: Any], completion: @escaping(Result<String, Error>) -> Void) {
        let reference = ref?.child("posts").childByAutoId()
        reference?.setValue(postDictionary) { (error: Error?, ref: DatabaseReference) in
            if let error = error {
                print("Error creating post at FirebaseDatabaseManager")
                completion(.failure(error))
            } else {
                print("Success creating post at FirebaseDatabaseManager")
                guard let childAutoId = reference?.key else { return }
                completion(.success(childAutoId))
            }
        }
    }
    
    func updatePost(postUID: String, postDictionary: [String: Any],
                    completion: @escaping(Result<Void, Error>) -> Void) {
        ref?.child("posts").child(postUID).updateChildValues(postDictionary) { (error: Error?, ref: DatabaseReference) in
            if let error = error {
                print("Error updating post at FirebaseDatabaseManager")
                completion(.failure(error))
            } else {
                print("Success updating post at FirebaseDatabaseManager")
                completion(.success(()))
            }
        }
    }
    
    func fetchAllPosts(completion: @escaping (Result<[PostModel], Error>) -> Void) {
        var posts: [PostModel] = []
        ref?.child("posts").observeSingleEvent(of: .value, with: { snapshot in
            if let value = snapshot.value as? NSDictionary {
                for key in value.allKeys {
                    if let postDict = value[key] as? [String: Any] {
                        var updatedPostDict = postDict
                        updatedPostDict["postUID"] = key as? String
                        let postUID = key as? String ?? ""
                        let userUID = postDict["user_uid"] as? String ?? ""
                        let username = postDict["username"] as? String ?? ""
                        let uploadTime = Formatting.stringToDateTime(strDate: postDict["upload_time"] as? String ?? "")
                        guard let imageURL = URL(string: postDict["image_url"] as! String) else { return }
                        let description = postDict["description"] as? String
                        let likes = postDict["likes"] as? Int
                        let bookmarks = postDict["bookmarks"] as? Int
                        let comments = postDict["comments"] as? [CommentModel] ?? []

                        let postModel = PostModel(postUID: postUID, userUID: userUID,
                                                  username: username, uploadTime: uploadTime,
                                                  imageUrl: imageURL, description: description,
                                                  likes: likes, bookmarks: bookmarks,
                                                  comments: comments)
                        posts.append(postModel)
                    }
                }
                print("Success fetching all posts at FirebaseDatabaseManager")
                completion(.success(posts))
            } else {
                print("Error fetching all posts at FirebaseDatabaseManager")
                let error = NSError(domain: "Error getting posts", code: -1, userInfo: nil)
                completion(.failure(error))
            }
        }) { error in
            completion(.failure(error))
        }
    }
}





//    func deleteDBUser(uid: String, completion: @escaping(Result<Void, Error>) -> Void) {
//        ref?.child("users").child(uid).removeValue() { error, _ in
//            if let error = error {
//                print("Error deleting user at Firebase Database Manager")
//                completion(.failure(error))
//            } else {
//                print("Success deleting user at Firebase Database Manager")
//                completion(.success(()))
//            }
//        }
//    }
