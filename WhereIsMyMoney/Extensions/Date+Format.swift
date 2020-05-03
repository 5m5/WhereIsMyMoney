//
//  Date+Format.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 04.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(with format: String = "dd.MM.yy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.init(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}
