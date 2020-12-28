//
//  ViewController.swift
//  Memes
//
//  Created by Felix Leitenberger on 09.07.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var topTextButton: UIButton!
    @IBOutlet var bottomTextButton: UIButton!
    
    var image: UIImage?
    var renderedImage: UIImage?
    
    var topText: String? {
        didSet {
            topTextButton.setTitle(topText, for: .normal)
        }
    }
    var bottomText: String? {
        didSet {
            bottomTextButton.setTitle(bottomText, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutButtons()
    }

    @IBAction func topTextTapped(_ sender: Any) {
        showAlertAndReceiveText(with: "Enter Top Text:") { text in
            self.topText = text
        }
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[.editedImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bottomTextTapped(_ sender: Any) {
        showAlertAndReceiveText(with: "Enter Bottom Text:") { text in
            self.bottomText = text
            }
        }
    
    @IBAction func renderTapped(_ sender: Any) {
        renderedImage = render()
        if let renderedMemeVC = storyboard?.instantiateViewController(identifier: "renderedMeme") as? RenderedMeme {
            renderedMemeVC.renderedImage = renderedImage
            present(renderedMemeVC, animated: true)
        }
    }
    
    
    func layoutButtons() {
        for button in buttons {
            button.layer.cornerRadius = 10
            button.layer.borderColor = UIColor.systemGray2.cgColor
        }
    }
    
    
    func showAlertAndReceiveText(with title: String, completion: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            if let textFieldtext = ac.textFields?[0].text {
                completion(textFieldtext)
            }
        }))
        present(ac, animated: true)
    }
    
    
    func render() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            
            image?.draw(in: CGRect(x: 0, y: 0, width: 512, height: 512))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 50, weight: .black),
                
                .strokeColor: UIColor.black,
                .strokeWidth: -4,
                .foregroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
            
            if let topText = topText {
            let topString = NSAttributedString(string: topText, attributes: attrs)
                topString.draw(with: CGRect(x: 32, y: 20, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            }
            
            if let bottomText = bottomText {
                let bottomString = NSAttributedString(string: bottomText, attributes: attrs)
                bottomString.draw(with: CGRect(x: 32, y: 440, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            }
        }
        return img
    }
}

