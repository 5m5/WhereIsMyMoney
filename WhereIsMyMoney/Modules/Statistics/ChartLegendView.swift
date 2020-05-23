//
//  ChartLegendView.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 23.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import UIKit

class ChartLegendView: UICollectionView {

    //override var numberOfSections: Int = 1
    
//    override func numberOfItems(inSection section: Int) -> Int {
//        10
//    }
//    
//    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
//        let cell = dequeueReusableCell(withReuseIdentifier: ChartLegendCell.reuseIdentifier,
//                                       for: indexPath)
//        
//        cell.backgroundColor = .blue
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ChartLegendCell.reuseIdentifier,
                                       for: indexPath)
        
        cell.backgroundColor = .blue
        return cell
    }

}
