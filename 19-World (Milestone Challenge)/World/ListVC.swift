//
//  ViewController.swift
//  World
//
//  Created by Felix Leitenberger on 16.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ListVC: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "World"
        navigationController?.navigationBar.prefersLargeTitles = true
        getCountries()
    }
    

    func getCountries() {
        if let data = NetworkManager.shared.getCountryData() {
            let decoder = JSONDecoder()
            if let countries = try? decoder.decode([Country].self, from: data) {
                self.countries = countries
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(identifier: "DetailVC") as? DetailVC {
            detailVC.country = countries[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

