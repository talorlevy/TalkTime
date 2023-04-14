//
//  SignUpString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum SignUpString: String {
    case getStartedLabel
    case usernamePlaceholder
    case firstNamePlaceholder
    case lastNamePlaceholder
    case emailPlaceholder
    case phonePlaceholder
    case passwordPlaceholder
    case confirmPasswordPlaceholder
    case dateOfBirthLabel
    case maleLabel
    case femaleLabel
    case signUpButton

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
