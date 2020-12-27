//
//  ShoppingListTableViewController.swift
//  Day_32_Consolidation Challenge
//
//  Created by Felix Leitenberger on 17.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear List", style: .plain, target: self, action: #selector(clearList))
    }
    
    
    @objc func addItem() {
        let ac = UIAlertController(title: "What do you want to buy?", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            if let itemText = ac.textFields?[0].text {
                print(itemText)
                self.items.insert(itemText, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }))
        present(ac, animated: true)
    }
    
    
    @objc func clearList() {
        items.removeAll()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
