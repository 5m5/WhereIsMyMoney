//
//  CustomTableViewCell.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 02.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var massAndCountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    // MARK: - Public Properties
    static let reuseIdentifier = "StatisticsCell"

}
