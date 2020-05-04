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
    func saveCategories(_ categories: [Category]) {
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
    
    func saveRecords(_ records: [Record]) {
        try! realm.write {
            realm.add(records)
        }
    }
    
    func deleteRecords(_ records: [Record]) {
        try! realm.write {
            realm.delete(records)
        }
    }
    
}
