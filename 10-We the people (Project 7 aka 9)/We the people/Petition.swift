//
//  Petition.swift
//  Day_33 Project7
//
//  Created by Felix Leitenberger on 19.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
