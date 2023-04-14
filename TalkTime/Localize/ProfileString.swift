//
//  EditProfileString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum ProfileString: String {
    case profileLabel
    case firstNamePlaceholder
    case lastNamePlaceholder
    case phonePlaceholder
    case myLocationButton
    case maleLabel
    case femaleLabel
    case saveButton
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
