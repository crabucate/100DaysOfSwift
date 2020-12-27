//
//  Person.swift
//  Names To Faces
//
//  Created by Felix Leitenberger on 31.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
