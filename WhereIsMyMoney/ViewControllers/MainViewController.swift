//
//  MainViewController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 01.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

final class MainViewController: UITableViewController {

    // MARK: - Private Properties
    private var records = realm.objects(Record.self).sorted(byKeyPath: "date", ascending: false)
    var segmentedControl: UISegmentedControl!
    
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
        
        cell.totalLabel.text = String(format: "%.2f", record.total) + "₽"
        cell.totalLabel.textColor = record.total >= 0 ? #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1) : .red
        
        cell.dateLabel.text = record.date.toString()
        
        cell.massOrCountLabel.text = {
            if let weight = record.weight.value {
                return String(weight) + " кг"
            } else if let count = record.count.value {
                return String(count) + " шт."
            }
            return nil
        }()

        return cell
    }
    
    // MARK: - Navigation
    @IBAction func unwindFromNewRecordVC(_ segue: UIStoryboardSegue) {
        guard let newRecordVC = segue.source as? NewRecordViewController else { return }
        
        newRecordVC.saveRecord()
        tableView.reloadData()
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
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            records = realm.objects(Record.self).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        case 1:
            records = realm.objects(Record.self).filter("isIncomeType == %@", false).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        case 2:
            records = realm.objects(Record.self).filter("isIncomeType == %@", true).sorted(byKeyPath: "date", ascending: false)
            tableView.reloadData()
        default:
            break
        }
    }

}
