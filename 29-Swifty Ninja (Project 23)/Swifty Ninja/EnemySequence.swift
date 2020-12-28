//
//  EnemySequence.swift
//  Swifty Ninja
//
//  Created by Felix Leitenberger on 02.07.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import Foundation

enum SequenceType: CaseIterable {
    case oneNoBomb, one, twoWithOneBomb, two, three, four, chain, fastChain
}

enum ForceBomb {
    case never, always, random
}
