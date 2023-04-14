////
////  EditProfileViewModel.swift
////  TalkTime
////
////  Created by Talor Levy on 3/10/23.
////
//
//import UIKit
//
//
//class DeleteEditProfileViewModel {
//
//    let firebaseDBManager: FirebaseDatabaseService
//    let firebaseStoreManager: FirebaseStorageService
//    var vc: UIViewController
//
//    init(firebaseDBManager: FirebaseDatabaseService,
//         firebaseStoreManager: FirebaseStorageService, vc: UIViewController) {
//        self.firebaseDBManager = firebaseDBManager
//        self.firebaseStoreManager = firebaseStoreManager
//        self.vc = vc
//    }
//
//
//
//    // MARK: - Firebase Database
//
//    func updateUser(uid: String, image: Data, userDictionary: [String: Any], completion: @escaping(Result<Void, Error>) -> Void) {
//        saveProfilePicture(uid: uid, image: image) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let url):
//                var userDictionaryWithPicture = userDictionary
//                userDictionaryWithPicture["profile_picture_url"] = url.absoluteString
//                self.firebaseDBManager.updateUser(uid: uid, userDictionary: userDictionaryWithPicture) { result in
//                    switch result {
//                    case .success(let userUpdatedDictionary):
//                        print("Success updating user at ProfileViewModel")
//                        LocalData.shared.currentUser?.firstName = userUpdatedDictionary["first_name"] as? String ?? ""
//                        LocalData.shared.currentUser?.lastName = userUpdatedDictionary["last_name"] as? String ?? ""
//                        LocalData.shared.currentUser?.phone = userUpdatedDictionary["phone"] as? String ?? ""
//                        LocalData.shared.currentUser?.gender = Formatting.stringToGender(strGender: userUpdatedDictionary["gender"] as? String ?? "")
//                        LocalData.shared.currentUser?.dateOfBirth = Formatting.stringToDate(strDate: userUpdatedDictionary["date_of_birth"] as? String ?? "")
//                        LocalData.shared.currentUser?.profilePictureUrl = URL(string: userUpdatedDictionary["profile_picture_url"] as? String ?? "")
//                        completion(.success(()))
//                    case .failure(let error):
//                        print("Error updating user at ProfileViewModel")
//                        completion(.failure(error))
//                    }
//                }
//            case .failure(_):
//                print("Error saving profile picture to storage and retrieving url at ProfileViewModel")
//                self.firebaseDBManager.updateUser(uid: uid, userDictionary: userDictionary) { result in
//                    switch result {
//                    case .success(_):
//                        print("Success updating user at ProfileViewModel without image")
//                    case .failure(let error):
//                        print("Error updating user at ProfileViewModel")
//                        completion(.failure(error))
//                    }
//                }
////                completion(.success(()))
//            }
//        }
//    }
//
//
//    // MARK: - Firebase Storage
//
//    func saveProfilePicture(uid: String, image: Data, completion: @escaping(Result<URL, Error>) -> Void) {
//        firebaseStoreManager.saveProfilePicture(uid: uid, image: image) { result in
//            switch result {
//            case .success(let downloadURL):
//                print("Success saving profile picture to storage and retrieving url at ProfileVM")
//                completion(.success(downloadURL))
//            case .failure(let error):
//                print("Error saving profile picture to storage and retrieving url at ProfileVM: \(error.localizedDescription)")
//                completion(.failure(error))
//            }
//        }
//    }
//}
