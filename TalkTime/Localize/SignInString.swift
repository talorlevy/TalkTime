//
//  SignInString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum SignInString: String {
    case emailPlaceholder
    case passwordPlaceholder
    case signInButton
    case signUpButton
    case facebookButton
    case googleButton

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
