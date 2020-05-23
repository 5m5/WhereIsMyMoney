//
//  StatisticsViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 13.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

final class StatisticsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var chartView: ChartView!
    
    // MARK: - Private Properties
    //private var records = realm.objects(Record.self)
    private var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
    }
    
    // MARK: - Private Methods
    private func setSegmentedControl() {
        let titles = ["Все", "Расходы", "Доходы"]
         segmentedControl = UISegmentedControl(items: titles)
         for index in 0...titles.count - 1 {
             segmentedControl.setWidth(80, forSegmentAt: index)
         }
         segmentedControl.sizeToFit()
         segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
         segmentedControl.selectedSegmentIndex = 0
         segmentedControl.sendActions(for: .valueChanged)
         navigationItem.titleView = segmentedControl
    }
    
    @objc private func segmentChanged() {
        var records = realm.objects(Record.self)
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            chartView.updateChartData()
        case 1:
            records = records.filter("isIncomeType == %@", false)
            chartView.updateExpenseData(records: records)
        case 2:
            records = records.filter("isIncomeType == %@", true)
        default:
            break
        }
    }
 
}
