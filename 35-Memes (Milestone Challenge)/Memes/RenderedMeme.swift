//
//  RenderedMeme.swift
//  Memes
//
//  Created by Felix Leitenberger on 09.07.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class RenderedMeme: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var renderedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let renderedImage = renderedImage {
            imageView.image = renderedImage
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let image = renderedImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your meme has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            })
            present(ac, animated: true)
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
