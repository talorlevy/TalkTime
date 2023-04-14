//
//  ImagePickerString.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import Foundation

enum ImagePickerString: String {
    case camera
    case gallery
    case cancel

    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
