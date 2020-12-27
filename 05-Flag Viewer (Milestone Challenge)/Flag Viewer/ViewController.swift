//
//  ViewController.swift
//  Day23_Consolidation Challenge
//
//  Created by Felix Leitenberger on 14.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var images = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImages()
        print(images)
    }


    func fetchImages() {
        let fm = FileManager()
        let path = Bundle.main.resourcePath
        let items = try! fm.contentsOfDirectory(atPath: path!)
        
        for item in items {
            if item.hasSuffix(".png") {
                images.append(item)
            }
        }
    }
}


extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath) as? FlagCell {
            cell.flag.image = UIImage(named: images[indexPath.row])
            cell.flag.clipsToBounds = true
            cell.flag.layer.cornerRadius = 10
            cell.flag.layer.borderWidth = 1
            cell.flag.layer.borderColor = UIColor.black.cgColor
            
            cell.label?.text = String(images[indexPath.row].split(separator: "@")[0]).uppercased()
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = images[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

