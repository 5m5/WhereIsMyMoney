//
//  CategoryViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit
import RealmSwift

final class CategoryViewController: UITableViewController {

    // MARK: - Public Properties
    var categoryType: CategoryType!
    var selectedCategory: Category?
    
    // MARK: - Private Properties
    private let reuseIdentifier = "CategoryCell"
    private var categories: Results<Category>!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = realm.objects(Category.self).filter(
            "type == %@ || type == %@",
            categoryType.rawValue,
            CategoryType.both.rawValue)
        
        if selectedCategory == nil {
            selectedCategory = categories.first
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryViewCell.reuseIdentifier,
            for: indexPath
            ) as! CategoryViewCell

        let category = categories[indexPath.row]
        cell.categoryNameLabel.text = String(category.name)
        cell.checkedCategoryLabel.isHidden = selectedCategory?.isSameObject(as: category) == false
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        performSegue(withIdentifier: "BackToNewRecordVC", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToNewRecordVC" {
            if let newRecordVC = segue.destination as? NewRecordViewController {
                newRecordVC.selectedCategory = selectedCategory
            }
        }
    }
    
}
