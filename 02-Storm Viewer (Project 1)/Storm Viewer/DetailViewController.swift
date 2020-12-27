//
//  DetailViewController.swift
//  Day_16 Project1
//
//  Created by Felix Leitenberger on 13.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var numberOfImages: Int?
    var actualImageNumber: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageNumber = actualImageNumber, let numberOfImages = numberOfImages {
            title = "Image \(imageNumber) of \(numberOfImages)"
        }
        navigationItem.largeTitleDisplayMode = .never

        if let image = selectedImage {
            imageView.image = UIImage(named: image)
        } else {
            print("Fail")
        }
    }
    
}
