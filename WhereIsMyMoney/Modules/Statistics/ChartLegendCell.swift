//
//  ChartLegendCell.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 23.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

class ChartLegendCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    // MARK: - Public Properties
    static let reuseIdentifier = "ChartLegendCell"
}
