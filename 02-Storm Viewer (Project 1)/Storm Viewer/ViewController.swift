//
//  ViewController.swift
//  Day_16 Project1
//
//  Created by Felix Leitenberger on 13.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Storm Viewer"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        loadDateFromBundle()
    }
    
    
    func loadDateFromBundle() {
        DispatchQueue.global(qos: .userInitiated).async {
            let fm =        FileManager()
            let path =      Bundle.main.resourcePath!
            let items =     try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    self.pictures.append(item)
                }
                
                self.pictures.sort()
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCell {
            cell.imageView.image = UIImage(named: pictures[indexPath.row])
            cell.label.text = pictures[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.numberOfImages = pictures.count
            vc.actualImageNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
