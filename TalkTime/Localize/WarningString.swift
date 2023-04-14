//
//  WarningString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum WarningString: String {
    case warning
    case ok
    case forgotFirstName
    case forgotLastName
    case forgotFirstAndLastName
    case invalidEmail
    case invalidPhone
    case forgotPassword
    case confirmPasswordDoesNotMatch
    case invalidDateOfBirth
    case forgotGender
    case usernameExists

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
