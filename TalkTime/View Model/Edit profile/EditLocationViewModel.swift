//
//  GoogleMapsViewModel.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit


class EditLocationViewModel {
    
    let firebaseDBManager: FirebaseDatabaseService
    var vc: UIViewController

    init(firebaseDBManager: FirebaseDatabaseService, vc: UIViewController) {
        self.firebaseDBManager = firebaseDBManager
        self.vc = vc
    }
    
    
    // MARK: - Firebase Database
    
    func updateUser(uid: String, userDictionary: [String: Any],
                      completion: @escaping(Result<Void, Error>) -> Void) {
        firebaseDBManager.updateUser(uid: uid, userDictionary: userDictionary) { result in
            switch result {
            case .success(let userDictionary):
                print("Success updating user at GoogleMapsViewModel")
                let latitude = userDictionary["latitude"] as! Double
                let longitude = userDictionary["longitude"] as! Double
                let location = Location(latitude: latitude, longitude: longitude)
                LocalData.shared.currentUser?.location = location
                completion(.success(()))
            case .failure(let error):
                print("Error updating user at GoogleMapsViewModel")
                completion(.failure(error))
            }
        }
    }
}
