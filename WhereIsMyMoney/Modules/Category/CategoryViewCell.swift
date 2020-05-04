//
//  CategoryViewCell.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 04.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var checkedCategoryLabel: UILabel!
    
    // MARK: - Public Properties
    static let reuseIdentifier = "CategoryCell"
    
}
