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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
