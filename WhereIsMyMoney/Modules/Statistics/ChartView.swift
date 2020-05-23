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
    private var records = realm.objects(Record.self)
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configurateChartView()
    }
    
    // MARK: - Public Methods
    func updateChartData() {
        let records = realm.objects(Record.self)
        
        let expenseRecords = records.filter("isIncomeType == %@", false)
        let expenseTotal = abs(expenseRecords.sum(ofProperty: "total") as Double)
        
        let expenseDataEntry = PieChartDataEntry(value: expenseTotal,
                                                 label: "Расходы \(expenseTotal)₽")
        
        let incomeRecords = records.filter("isIncomeType == %@", true)
        let incomeTotal = incomeRecords.sum(ofProperty: "total") as Double
        
        let incomeDataEntry = PieChartDataEntry(value: incomeTotal,
                                                label: "Доходы \(incomeTotal)₽")
        
        let dataEntries = [expenseDataEntry, incomeDataEntry]
        createDataEntries(dataEntries, colors: [.expense, .income])
    }
    
    func updateCategories(_ categories: Results<Category>, colors: [UIColor]) {
        var dataEntries = [PieChartDataEntry]()
        
        for category in categories {
            let total = abs(category.records.sum(ofProperty: "total") as Double)
            
            let dataEntry = PieChartDataEntry(value: total,
                                              label: "\(category.name) \(total)₽")
            
            if total > 0 { dataEntries.append(dataEntry) }
        }
        
        createDataEntries(dataEntries, colors: colors)
    }
    
    // MARK: - Private Methods
    private func createDataEntries(_ dataEntries: [PieChartDataEntry], colors: [UIColor]) {
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        //Disable marks
        chartDataSet.drawValuesEnabled = false
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter())
        chartData.setValueFont(UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)!)
        chartDataSet.colors = colors
        
        data = chartData
    }
    
    private func configurateChartView() {
        legend.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)!
        legend.textColor = .label
        legend.horizontalAlignment = .center
        
        drawHoleEnabled = false
        rotationAngle = 0
        rotationEnabled = false
        isUserInteractionEnabled = false
        
        //chartDescription?.text = nil
        
        drawEntryLabelsEnabled = false
    }
    
    private func formatter() -> IValueFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        
        return DefaultValueFormatter(formatter: formatter)
    }
    
}

//        for _ in 0..<dataEntries.count {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double(arc4random_uniform(256))
//
//            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//            chartDataSet.colors.append(color)
//        }
