//
//  Validation.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 3/1/23.
//

import Foundation
import UIKit

class Validation {
    
    static func validateSignUp(email: String, username: String, firstName: String, lastName: String, phone: String,
                               password: String, confirmPassword: String, dateOfBirth: Date,
                               gender: Constants.Gender, vc: UIViewController) -> Bool {
        if !validateEmail(email: email, vc: vc) { return false }
        if !validateUsername(username: username, vc: vc) { return false }
        if !validateName(firstName: firstName, lastName: lastName, vc: vc) { return false }
        if !validatePhoneNumber(phoneNumber: phone, vc: vc) { return false }
        if !validatePassword(password: password, confirmation: confirmPassword, vc: vc) { return false }
        if !validateDateOfBirth(date: dateOfBirth, vc: vc) { return false }
        if !validateGender(gender: gender, vc: vc) { return false }
        return true
    }
    
    static func validateProfileUpdate(firstName: String, lastName: String, phone: String, dateOfBirth: Date,
                                      gender: Constants.Gender, vc: UIViewController) -> Bool {
        if !validateName(firstName: firstName, lastName: lastName, vc: vc) { return false }
        if !validatePhoneNumber(phoneNumber: phone, vc: vc) { return false }
        if !validateDateOfBirth(date: dateOfBirth, vc: vc) { return false }
        if !validateGender(gender: gender, vc: vc) { return false }
        return true
    }
    
    static func validateEmail(email: String, vc: UIViewController) -> Bool {
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = email.range(of: emailPattern, options: .regularExpression)
        if result == nil {
            let alertController = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.invalidEmail.localized.firstUppercased, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .cancel)
            alertController.addAction(okayAction)
            vc.present(alertController, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    static func validateUsername(username: String, vc: UIViewController) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9]+([\\_\\-]?[a-zA-Z0-9])*$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        let length = username.count
        if usernameTest.evaluate(with: username) && length >= 6 && length <= 20 && !username.hasPrefix("_") && !username.hasPrefix("-") && !username.hasSuffix("_") && !username.hasSuffix("-") {
            return true
        } else {
            let alertController = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.invalidEmail.localized.firstUppercased, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .cancel)
            alertController.addAction(okayAction)
            vc.present(alertController, animated: true, completion: nil)
            return false
        }
    }
    
    static func validateName(firstName: String, lastName: String, vc: UIViewController) -> Bool {
        if firstName == "" && lastName == "" {
            let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.forgotFirstAndLastName.localized.firstUppercased, preferredStyle: .alert)
            let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default)
            alert.addAction(okAction)
            vc.present(alert, animated: true)
            return false
        } else if firstName == "" {
            let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.forgotFirstName.localized.firstUppercased, preferredStyle: .alert)
            let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default)
            alert.addAction(okAction)
            vc.present(alert, animated: true)
            return false
        } else if lastName == "" {
            let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.forgotLastName.localized.firstUppercased, preferredStyle: .alert)
            let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default)
            alert.addAction(okAction)
            vc.present(alert, animated: true)
            return false
        } else { return true }
    }
    
    static func validatePhoneNumber(phoneNumber: String, vc: UIViewController) -> Bool {
        let phoneRegex = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        if !predicate.evaluate(with: phoneNumber) {
            let alertController = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.invalidPhone.localized.firstUppercased, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .cancel)
            alertController.addAction(okayAction)
            vc.present(alertController, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    static func validatePassword(password: String, confirmation: String, vc: UIViewController) -> Bool {
        if password == "" {
            let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.forgotPassword.localized.firstUppercased, preferredStyle: .alert)
            let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default)
            alert.addAction(okAction)
            vc.present(alert, animated: true)
            return false
        }
        if password != confirmation {
            let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.confirmPasswordDoesNotMatch.localized.firstUppercased, preferredStyle: .alert)
            let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default)
            alert.addAction(okAction)
            vc.present(alert, animated: true)
            return false
        } else { return true }
    }
    
    static func validateDateOfBirth(date: Date, vc: UIViewController) -> Bool {
        if date >= Date() {
            let alertController = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.invalidDateOfBirth.localized.firstUppercased, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .cancel)
            alertController.addAction(okayAction)
            vc.present(alertController, animated: true, completion: nil)
            return false
        } else { return true}
    }
    
    static func validateGender(gender: Constants.Gender, vc: UIViewController) -> Bool {
        if gender == Constants.Gender.undefined {
            let alertController = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.forgotGender.localized.firstUppercased, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .cancel)
            alertController.addAction(okayAction)
            vc.present(alertController, animated: true, completion: nil)
            return false
        } else { return true }
    }
}
