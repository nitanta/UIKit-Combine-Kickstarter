//
//  StringExtension.swift
//  yayos
//
//  Created by Nitanta Adhikari on 11/12/18.
//  Copyright © 2018 Aatish Rajkarnikar. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    func separate(every: Int, with separator: String) -> String {
        return String(stride(from: 0, to: Array(self).count, by: every).map {
            Array(Array(self)[$0..<min($0 + every, Array(self).count)])
            }.joined(separator: separator))
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func separateString(delimiter: String) -> String {
        let token = self.components(separatedBy: delimiter)
        return token[1]
    }
}

extension Optional where Wrapped == String {
    func unwrapSafely() -> String {
        if let value = self {
            return value
        }
        return ""
    }
}
