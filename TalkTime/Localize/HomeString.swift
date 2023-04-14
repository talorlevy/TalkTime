//
//  HomeString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum HomeString: String {
    case example

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
