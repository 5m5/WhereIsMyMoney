//
//  CategoryViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

final class CategoryViewController: UITableViewController {

    // MARK: - Private Properties
    private let reuseIdentifier = "CategoryCell"
    private let categories = realm.objects(Category.self)

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = String(categories[indexPath.row].name)
        
        return cell
    }

}
