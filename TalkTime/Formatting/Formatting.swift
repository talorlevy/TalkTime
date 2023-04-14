//
//  Formatting.swift
//  TalkTime
//
//  Created by Talor Levy on 3/3/23.
//

import Foundation
import CoreLocation


struct Formatting {
    
    static func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    static func stringToDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.date(from: strDate)
        return date ?? Date()
    }
    
    static func dateTimeToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let strDateTime = dateFormatter.string(from: date)
        return strDateTime
    }
    
    static func stringToDateTime(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss.SSS"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: strDate) {
            let localTimeZone = TimeZone.current
            let localCalendar = Calendar.current
            let utcOffset = TimeInterval(localTimeZone.secondsFromGMT(for: date))
            let localDate = Date(timeInterval: utcOffset, since: date)
            return localCalendar.date(from: localCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: localDate)) ?? Date()
        }
        return Date()
    }


    
    static func genderToString(gender: Constants.Gender) -> String {
        switch gender {
        case .male:
            return "Male"
        case .female:
            return "Female"
        default:
            return ""
        }
    }
    
    static func stringToGender(strGender: String) -> Constants.Gender {
        if strGender == Constants.Gender.male.rawValue {
            return Constants.Gender.male
        }
        if strGender == Constants.Gender.female.rawValue {
            return Constants.Gender.female
        }
        else {
            return Constants.Gender.undefined
        }
    }
    
    static func stringToProvider(strProvider: String) -> Constants.Provider {
        if strProvider == Constants.Provider.email.rawValue {
            return Constants.Provider.email
        }
        if strProvider == Constants.Provider.google.rawValue {
            return Constants.Provider.google
        }
        if strProvider == Constants.Provider.facebook.rawValue {
            return Constants.Provider.facebook
        }
        else {
            return Constants.Provider.undefined
        }
    }
    
    static func getCityAndStateFromLatLong(latitude: Double, longitude: Double,
                                           completion: @escaping (Result<String, Error>) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(.failure(error))
            }
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? ""
                let state = placemark.administrativeArea ?? ""
                let result = "\(city), \(state)"
                completion(.success(result))
            }
        }
    }
    
    static func userToDictionary(userModel: UserModel) -> [String: Any] {
        var userDictionary = [String: Any]()
        let uid = userModel.uid
        let email = userModel.email
        let username = userModel.username
        let provider = userModel.provider.rawValue
        let firstName = userModel.firstName ?? ""
        let lastName = userModel.lastName ?? ""
        let phone = userModel.phone ?? ""
        let dateOfBirth = dateToString(date: userModel.dateOfBirth ?? Date())
        let gender = genderToString(gender: userModel.gender ?? Constants.Gender.undefined)
        let latitude = userModel.location?.latitude
        let longitude = userModel.location?.longitude
        let profilePictureUrl = userModel.profilePictureUrl?.absoluteString ?? ""
        let bio = userModel.bio ?? ""
        userDictionary["uid"] = NSString(string: uid)
        userDictionary["provider"] = NSString(string: provider)
        userDictionary["email"] = NSString(string: email)
        userDictionary["username"] = NSString(string: username)
        userDictionary["first_name"] = NSString(string: firstName)
        userDictionary["last_name"] = NSString(string: lastName)
        userDictionary["phone"] = NSString(string: phone)
        userDictionary["date_of_birth"] = NSString(string: dateOfBirth)
        userDictionary["gender"] = NSString(string: gender)
        userDictionary["latitude"] = latitude
        userDictionary["longitude"] = longitude
        userDictionary["profile_picture_url"] = NSString(string: profilePictureUrl)
        userDictionary["bio"] = NSString(string: bio)
        return userDictionary
    }
    
    static func postToDictionary(postModel: PostModel) -> [String: Any] {
        var postDictionary = [String: Any]()
        let userUID = postModel.userUID
        let postUID = postModel.postUID ?? ""
        let uploadTime = Formatting.dateTimeToString(date: postModel.uploadTime)
        let description = postModel.description ?? ""
        let imageUrl = postModel.imageUrl?.absoluteString ?? ""
        let likes = postModel.likes ?? 0
        let userProfilePictureUrl = postModel.userProfilePictureUrl?.absoluteString ?? ""
        postDictionary["user_uid"] = NSString(string: userUID)
        postDictionary["post_uid"] = NSString(string: postUID)
        postDictionary["upload_time"] = NSString(string: uploadTime)
        postDictionary["description"] = NSString(string: description)
        postDictionary["image_url"] = NSString(string: imageUrl)
        postDictionary["likes"] = likes
        postDictionary["user_profile_picture"] = NSString(string: userProfilePictureUrl)
        return postDictionary
    }
}
