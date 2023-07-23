//
//  ChartDayCell.swift
//  POS App
//
//  Created by namnl on 23/07/2023.
//

import UIKit
import DGCharts

class ChartDayCell: UITableViewCell,ChartViewDelegate {
    
    @IBOutlet var chartView: UIView!
    var barChartView: BarChartView!
    var data = [PBookCalender]()
    override func awakeFromNib() {
        super.awakeFromNib()
        barChartView = BarChartView(frame: CGRect(x: 0, y: 0, width: chartView.frame.width - 50, height: chartView.frame.height))
        chartView.addSubview(barChartView)
        setupHorizontalBarChart()
        barChartView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindData (item: [PBookCalender]){
        data = item
    }
    func setupHorizontalBarChart() {
        // Sample data for the chart
        //        let dataEntries: [BarChartDataEntry] = [
        //            BarChartDataEntry(x: 1, y: 10),
        //            BarChartDataEntry(x: 2, y: 20),
        //            BarChartDataEntry(x: 3, y: 15),
        //            BarChartDataEntry(x: 4, y: 25),
        //            BarChartDataEntry(x: 5, y: 30)
        //        ]
        var dataEntries = [BarChartDataEntry]()
        for x in 0..<31 {
            dataEntries.append(BarChartDataEntry(x: Double(x), y: Double.random(in: 100000...4000000)))
        }
        let dataSet = BarChartDataSet(entries: dataEntries, label: "Cột tương ứng với ngày")
        
        // Add data labels to the chart
        dataSet.valueFormatter = DefaultValueFormatter(decimals: 0)
        dataSet.valueTextColor = .black
        
        dataSet.drawValuesEnabled = false // Enable displaying data values on the bars
        
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
        barChartView.doubleTapToZoomEnabled = false
        // Hide all the labels and axes
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        
        // Hide grid lines
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        
    }
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        // Show the data value for the selected column
        let value = entry.y
        print("Selected Column Value: \(value)")
    }
    
    // Called when nothing is selected or an "un-select" has been made.
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        // Hide or do something when no column is selected
    }
}
