//
//  Country.swift
//  World
//
//  Created by Felix Leitenberger on 16.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var flag: URL
    var currencies: [Currency]
}

struct Currency: Codable {
    var name: String?
}
