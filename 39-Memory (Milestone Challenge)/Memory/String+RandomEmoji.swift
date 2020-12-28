//
//  String+RandomEmoji.swift
//  Memory
//
//  Created by Felix Leitenberger on 15.07.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import Foundation

extension String {
    static var randomEmoji: String {
        let range = 0x1F600...0x1F636
        let randomEmoji = range.randomElement()
        
        return UnicodeScalar(randomEmoji!)!.description
    }
}
