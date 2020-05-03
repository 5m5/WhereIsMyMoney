//
//  RecordModel.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Foundation
import RealmSwift

@objc enum RecordType: UInt8 {
    case both
    case income
    case expense
}

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var iconData: Data?
    @objc dynamic var type: RecordType = .both
    
    convenience init(name: String, iconData: Data?, type: RecordType) {
        self.init()
        self.name = name
        self.iconData = iconData
        self.type = type
    }
    
}

class Record: Object {
    @objc dynamic var total = 0.0
    @objc dynamic var weight = 0.0
    @objc dynamic var commentary: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var selectedCategory: Category!
    
    convenience init(total: Double,
                     weight: Double,
                     commentary: String?,
                     imageData: Data?,
                     date: Date,
                     selectedCategory: Category) {
        self.init()
        self.total = total
        self.weight = weight
        self.imageData = imageData
        self.date = date
        self.selectedCategory = selectedCategory
    }
    
}
