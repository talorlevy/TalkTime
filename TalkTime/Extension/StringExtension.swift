//
//  StringExtension.swift
//  TalkTime
//
//  Created by Talor Levy on 3/7/23.
//

import Foundation

extension String {
    
    var firstUppercased: String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
}
