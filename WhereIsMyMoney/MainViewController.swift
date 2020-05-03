//
//  MainViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 01.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {

    // MARK: - Private Properties
    private var records = realm.objects(Record.self)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentedControl()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.reuseIdentifier,
            for: indexPath
            ) as! CustomTableViewCell
        
        let record = records[indexPath.row]
        
        cell.nameLabel.text = record.name ?? record.selectedCategory.name
        cell.totalLabel.text = String(record.total)
        
        cell.massOrCountLabel.text = {
            if let weight = record.weight.value {
                return String(weight)
            } else if let count = record.count.value {
                return String(count)
            }
            return nil
        }()

        return cell
    }
    
    // MARK: - Private Methods
    func setSegmentedControl() {
        let titles = ["Все", "Доходы", "Расходы"]
         let segmentControl = UISegmentedControl(items: titles)
         for index in 0...titles.count - 1 {
             segmentControl.setWidth(80, forSegmentAt: index)
         }
         segmentControl.sizeToFit()
         //segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
         segmentControl.selectedSegmentIndex = 0
         segmentControl.sendActions(for: .valueChanged)
         navigationItem.titleView = segmentControl
    }

}
