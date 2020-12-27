//
//  DetailVC.swift
//  Inventory
//
//  Created by Felix Leitenberger on 10.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var caption: String?
    var image: UIImage?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = caption
        imageView.image = image
    }

}
