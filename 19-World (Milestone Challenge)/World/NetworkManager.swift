//
//  NetworkManager.swift
//  World
//
//  Created by Felix Leitenberger on 16.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let urlString = "https://restcountries.eu/rest/v2/all"
    
    private init() { }
    
    func getCountryData() -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        if let data = try? Data(contentsOf: url) {
            return data
        } else {
            return nil
        }
    }
}

