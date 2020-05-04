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
}
