//
//  UsernameGenerator.swift
//  TalkTime
//
//  Created by Talor Levy on 3/30/23.
//

import Foundation


struct Generator {
    static func generateUsername() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 0..<16 {
            let randomIndex = Int.random(in: 0..<letters.count)
            let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
            randomString.append(randomCharacter)
        }
        return randomString
    }
}
