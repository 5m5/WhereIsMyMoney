//
//  RealmController.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 03.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmController {
    static func setSchemaVersion() {
        let schemaVersion: UInt64 = 3
        let config = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: nil)
        Realm.Configuration.defaultConfiguration = config
    }
    
    static func initRealm() {
        guard let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path else {
            return
        }
        let path = Bundle.main.path(forResource: "default", ofType: "realm")
        if !FileManager.default.fileExists(atPath: defaultPath), let bundledPath = path {
            do {
                try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath)
            } catch {
                print("Error copying pre-populated Realm \(error)")
            }
        }
    }
    
}
