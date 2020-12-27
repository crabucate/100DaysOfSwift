//
//  ListVC.swift
//  Inventory
//
//  Created by Felix Leitenberger on 10.06.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ListVC: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var things = [Thing]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inventory"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        let defaults = UserDefaults()
        if let savedThings = defaults.object(forKey: "things") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                things = try jsonDecoder.decode([Thing].self, from: savedThings)
            } catch {
                print("Failed to load things")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return things.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ThingCell") as? ThingCell {
            cell.thingImageView.layer.borderColor = UIColor.gray.cgColor
            cell.thingImageView.layer.borderWidth = 1
            let imagePath = getDocumentsDirectory().appendingPathComponent(things[indexPath.row].filename)
            cell.thingImageView.image = UIImage(contentsOfFile: imagePath.path)
            cell.thingLabel.text = things[indexPath.row].caption
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(identifier: "DetailVC") as? DetailVC {
            detailVC.caption = things[indexPath.row].caption
            let imagePath = getDocumentsDirectory().appendingPathComponent(things[indexPath.row].filename)
            detailVC.image = UIImage(contentsOfFile: imagePath.path)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    @objc func addItem() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        
        dismiss(animated: true, completion: {
            let alert = UIAlertController(title: "Name this thing!", message: nil, preferredStyle: .alert)
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "Use this name", style: .default, handler: { (_) in
                let thing = Thing(filename: imageName, caption: alert.textFields?[0].text ?? "Unnamed")
                self.things.append(thing)
                self.save()
                self.tableView.reloadData()
            }))
            self.present(alert, animated: true)
        })
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(things) {
            let defaults = UserDefaults()
            defaults.set(savedData, forKey: "things")
        } else {
            print("Failed to save things!")
        }
    }

}

