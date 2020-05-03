//
//  RecordModel.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Foundation
import RealmSwift

@objc enum CategoryType: Int, RealmEnum {
    case both
    case income
    case expense
}

final class Category: Object {
    @objc dynamic var name = ""
    let type = RealmOptional<CategoryType>()
    
    // MARK: - Initializers
    convenience init(name: String, type: CategoryType) {
        self.init()
        self.name = name
        self.type.value = type
    }
    
}

final class Record: Object {
    @objc dynamic var name: String?
    @objc dynamic var total = 0.0
    @objc dynamic var isIncomeType = false
    let weight = RealmOptional<Double>()
    let count = RealmOptional<Int>()
    @objc dynamic var commentary: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var selectedCategory: Category!
    
    // MARK: - Initializers
    convenience init(name: String? = nil,
                     total: Double,
                     isIncomeType: Bool,
                     weight: Double? = nil,
                     count: Int? = nil,
                     commentary: String? = nil,
                     imageData: Data? = nil,
                     date: Date,
                     selectedCategory: Category) {
        self.init()
        self.name = name
        self.total = total
        self.isIncomeType = isIncomeType
        self.weight.value = weight
        self.count.value = count
        self.imageData = imageData
        self.date = date
        self.selectedCategory = selectedCategory
    }
    
}
