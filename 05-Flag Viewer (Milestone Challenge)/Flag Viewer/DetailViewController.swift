//
//  DetailViewController.swift
//  Day23_Consolidation Challenge
//
//  Created by Felix Leitenberger on 14.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
        configureShareButton()
    }

    
    fileprivate func configureImage() {
        if let image = selectedImage {
            imageView.image = UIImage(named: image)
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1
        } else {
            print("No image found")
        }
    }
    
    
    func configureShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }
    
    
    @objc func share() {
        guard let image = imageView.image else { return }
        
        let ac = UIActivityViewController(activityItems: [image], applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}
