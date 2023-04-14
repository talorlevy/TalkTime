//
//  LanguageString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum LanguageString: String {
    case englishButton
    case spanishButton
    case germanButton

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
