//
//  ChartView.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 13.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Charts
import RealmSwift

final class ChartView: PieChartView {
    
    // MARK: - Private Properties
    private var colors: [UIColor] = [.systemBlue,
                                     .systemOrange,
                                     .systemPink,
                                     .systemTeal,
                                     .systemIndigo,
                                     .systemGreen,
                                     .systemRed,
                                     .systemYellow]
    
    // MARK: - Public Methods
    func updateChartData() {
        drawHoleEnabled = false
        rotationAngle = 0
        rotationEnabled = false
        isUserInteractionEnabled = false
        
        //chartDescription?.text = nil
        usePercentValuesEnabled = true
        legend.horizontalAlignment = .center
        
        drawEntryLabelsEnabled = false
        
        let expenseTotal = realm.objects(Record.self).filter("isIncomeType == %@", false).sum(ofProperty: "total") as Double
        
        let expenseDataEntry = PieChartDataEntry(value: abs(expenseTotal),
                                                 label: "Расходы")
        
        let incomeDataEntry = PieChartDataEntry(
            value: realm.objects(Record.self).filter("isIncomeType == %@", true).sum(ofProperty: "total"),
            label: "Доходы"
        )
        
        let dataEntries = [expenseDataEntry, incomeDataEntry]
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        //Disable marks
        chartDataSet.drawValuesEnabled = false
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter())
        chartData.setValueFont(UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)!)
        legend.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24.0)!
        legend.textColor = .label
        holeColor = nil
        chartDataSet.colors = [.expense, .income]
        data = chartData
    }
    
    func updateExpenseData(records: Results<Record>) {
        clear()
        
        drawHoleEnabled = false
        rotationAngle = 0
        rotationEnabled = false
        isUserInteractionEnabled = false
        
        usePercentValuesEnabled = true
        legend.horizontalAlignment = .center
        
        drawEntryLabelsEnabled = false
        
        let categories = realm.objects(Category.self).filter("type == %@", CategoryType.expense.rawValue)
        
        var dataEntries = [PieChartDataEntry]()
        
        for category in categories {
            let total = abs(category.records.sum(ofProperty: "total") as Double)
            
            let dataEntry = PieChartDataEntry(
                value: abs(category.records.sum(ofProperty: "total")),
                label: category.name
            )
            
            if total > 0 {
                dataEntries.append(dataEntry)
            }
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        //Disable marks
        chartDataSet.drawValuesEnabled = false
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter())
        chartData.setValueFont(UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)!)
        legend.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24.0)!
        legend.textColor = .label
        chartDataSet.colors = colors

//        for _ in 0..<dataEntries.count {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double(arc4random_uniform(256))
//
//            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//            chartDataSet.colors.append(color)
//        }
        
        data = chartData
        
    }
    
    // MARK: - Private Methods
    func formatter() -> IValueFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        
        return DefaultValueFormatter(formatter: formatter)
    }
    
}


//open class var red: UIColor { get } // 1.0, 0.0, 0.0 RGB
//
//open class var green: UIColor { get } // 0.0, 1.0, 0.0 RGB
//
//open class var blue: UIColor { get } // 0.0, 0.0, 1.0 RGB
//
//open class var cyan: UIColor { get } // 0.0, 1.0, 1.0 RGB
//
//open class var yellow: UIColor { get } // 1.0, 1.0, 0.0 RGB
//
//open class var magenta: UIColor { get } // 1.0, 0.0, 1.0 RGB
//
//open class var orange: UIColor { get } // 1.0, 0.5, 0.0 RGB
//
//open class var purple: UIColor { get } // 0.5, 0.0, 0.5 RGB
//
//open class var brown: UIColor { get } // 0.6, 0.4, 0.2 RGB


//open class var systemRed: UIColor { get }
//
//@available(iOS 7.0, *)
//open class var systemGreen: UIColor { get }
//
//@available(iOS 7.0, *)
//open class var systemBlue: UIColor { get }
//
//@available(iOS 7.0, *)
//open class var systemOrange: UIColor { get }
//
//@available(iOS 7.0, *)
//open class var systemYellow: UIColor { get }
//
//@available(iOS 7.0, *)
//open class var systemPink: UIColor { get }
//
//@available(iOS 9.0, *)
//open class var systemPurple: UIColor { get }
//
//@available(iOS 7.0, *)
//open class var systemTeal: UIColor { get }
//
//@available(iOS 13.0, *)
//open class var systemIndigo: UIColor { get }
