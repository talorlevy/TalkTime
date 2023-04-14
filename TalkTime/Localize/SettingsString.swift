//
//  SettingsString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum SettingsString: String {
    case profileButton
    case languageButton
    case signOutButton

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
