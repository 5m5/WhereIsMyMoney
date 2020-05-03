//
//  StorageManager.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

let storageManager = StorageManager.shared

final class StorageManager {
    
    // MARK: - Private Properties
    static fileprivate let shared = StorageManager()
    
    // MARK: - Initializers
    private init() { }
    
    // MARK: - Public Methods
    func setDefaultCategories() {
        let expenseCategoriesNames = ["Наполнители", "Клей", "Краска", "Провода",
                                      "Аккумуляторы", "Двери", "Перчатки", "Трансформаторы",
                                      "Генераторы", "Трубы", "Топливо", "Сталь", "Пластик"]
        
        let incomeCategoriesNames = ["Блок-контейнеры для оборудования",
                                     "Блок-контейнеры из сэндвич-панелей",
                                     "Комплектные трансформаторные подстанции",
                                     "Мини-ТЭС с утилизацией тепла",
                                     "Электрогенераторные установки",
                                     "Нерегулируемые УКРМ",
                                     "Автоматические УКРМ",
                                     "Контейнерные УКРМ"]
        
        var categories = [Category]()
        for categoryName in expenseCategoriesNames {
            let newCategory = Category(name: categoryName, type: .expense)
            categories.append(newCategory)
        }
        
        for categoryName in incomeCategoriesNames {
            let newCategory = Category(name: categoryName, type: .income)
            categories.append(newCategory)
        }
        
        addCategories(categories)
    }
    
    func setDefaultRecords() {
        let categories = realm.objects(Category.self)
        
        let record = Record(total: 1900,
                            isIncomeType: true,
                            count: 11,
                            commentary: "Производство Германия",
                            date: Date(),
                            selectedCategory: categories.first!)
        
        addRecords([record])
    }
    
    func addCategories(_ categories: [Category]) {
        try! realm.write {
            realm.add(categories)
        }
//        DispatchQueue(label: "background").async {
//            autoreleasepool {
//                try! realm.write {
//                    realm.add(categories)
//                }
//            }
//        }
    }
    
    func addRecords(_ records: [Record]) {
        try! realm.write {
            realm.add(records)
        }
    }
    
}
