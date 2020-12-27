//
//  ViewController.swift
//  Day_16 Project1
//
//  Created by Felix Leitenberger on 13.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Image]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Storm Viewer"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let defaults = UserDefaults()
        if let savedData = defaults.data(forKey: "images") {
             let decoder = JSONDecoder()
            do {
                try pictures = decoder.decode([Image].self, from: savedData)
            } catch {
                print("Failed to load Images")
            }
        } else {
            print("UserDefaults empty. Fixing...")
            let fm =        FileManager()
            let path =      Bundle.main.resourcePath!
            let items =     try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    pictures.append(Image(fileName: item, counter: 0))
                }
            }
            save()
        }
    }
    
    
    func save() {
        let encoder = JSONEncoder()
        if let savedData = try? encoder.encode(pictures) {
            let defaults = UserDefaults()
            defaults.set(savedData, forKey: "images")
        } else {
            print("Failed to save to UserDefaults.")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].fileName
        cell.detailTextLabel?.text = "\(pictures[indexPath.row].counter) Views"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].fileName
            pictures[indexPath.row].counter += 1
            save()
            tableView.reloadData()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

