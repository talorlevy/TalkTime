//
//  TabBarControllerString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/15/23.
//

import Foundation

enum MainTabBarControllerString: String {
    case homeTab
    case messageTab
    case postTab
    case searchTab
    case settingsTab

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
