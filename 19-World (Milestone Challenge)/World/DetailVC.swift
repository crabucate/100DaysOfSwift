//
//  DetailVC.swift
//  World
//
//  Created by Felix Leitenberger on 18.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit
import Macaw

class DetailVC: UIViewController {
    
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var flagImageView: SVGView!
    
    var country: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
        title = country?.name
    }
    
    
    func populateLabels() {
        if let country = country {
            capitalLabel.text = country.capital
            populationLabel.text = "\(country.population)"
            
            if let text = try? String(contentsOf: country.flag, encoding: String.Encoding.utf8) {
                flagImageView.node = try! SVGParser.parse(text: text)
                flagImageView.contentMode = .scaleAspectFit
                flagImageView.clipsToBounds = true
                flagImageView.backgroundColor = .tertiarySystemGroupedBackground
            }
            
            
            for currency in country.currencies {
                if currencyLabel.text?.isEmpty ?? true {
                    currencyLabel.text?.append(currency.name ?? "N/A")
                } else {
                    currencyLabel.text?.append("\n" + (currency.name ?? "N/A"))
                }
            }
            
        }
    }

}
