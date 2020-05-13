//
//  ChartView.swift
//  WhereIsMyMoney
//
//  Created by Mikhail Andreev on 13.05.2020.
//  Copyright © 2020 Mikhail Andreev. All rights reserved.
//

import Charts

final class ChartView: PieChartView {
    
    // MARK: - Public Methods
    func updateChartData() {
        let expenseDataEntry = PieChartDataEntry(value:
            realm.objects(Record.self).filter("isIncomeType == %@", false).sum(ofProperty: "total")
        )
        expenseDataEntry.label = "Расходы"
        expenseDataEntry.accessibilityValue = nil
        let incomeDataEntry = PieChartDataEntry(value:
            realm.objects(Record.self).filter("isIncomeType == %@", true).sum(ofProperty: "total")
        )
        incomeDataEntry.label = "Доходы"
        let dataEntries = [expenseDataEntry, incomeDataEntry]
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        
        //chartDescription?.text = nil
        usePercentValuesEnabled = true
        legend.horizontalAlignment = .center
        
        //Disable marks
        chartDataSet.drawValuesEnabled = false
        drawEntryLabelsEnabled = false
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter())
        chartData.setValueFont(UIFont(name: "AppleSDGothicNeo-Light", size: 14.0)!)
        legend.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24.0)!
        legend.textColor = .label
        holeColor = nil
        let colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)]
        chartDataSet.colors = colors
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
