//
//  ChartDayCell.swift
//  POS App
//
//  Created by namnl on 23/07/2023.
//

import UIKit
import DGCharts

class ChartDayCell: UITableViewCell,ChartViewDelegate {
    
    
    var dataSelect: String?
    var actionViewList: ClosureCustom<Int64>?
    @IBOutlet var boundsView: UIView!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet var chartView: UIView!
    var barChartView: BarChartView!
    var data = [ChartDay]()
    override func awakeFromNib() {
        super.awakeFromNib()
        barChartView = BarChartView(frame: CGRect(x: -10, y: 0, width: chartView.frame.width - 29 , height: chartView.frame.height))
        chartView.addSubview(barChartView)
        barChartView.delegate = self
        setupUI()
    }
    func setupUI() {
        boundsView.layer.cornerRadius = myCornerRadius.corner5
        boundsView.layer.borderWidth = 0.1
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindData (item: [ChartDay]){
        data = item
        setupHorizontalBarChart()
        let e = data.itemAtIndex(index: 0)
        dateLbl.text = "Ngày: \(e?.date ?? "")"
        moneyLbl.text = "Doanh thu: \(e?.money ?? 0)đ - Lượt khach: \(e?.recordsCount ?? 0) "
        dataSelect = e?.date ?? ""
        
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
        for x in 0..<data.count {
            dataEntries.append(BarChartDataEntry(x: Double(x), y: Double(data[x].money ?? 0)))
        }
        let dataSet = BarChartDataSet(entries: dataEntries, label: "Chạm vào cột để xem thông tin")
        
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
        let item = data.itemAtIndex(index: Int(entry.x))
        dateLbl.text = "Ngày: \(item?.date ?? "")"
        dataSelect = item?.date ?? ""
        moneyLbl.text = "Doanh thu: \(String(describing: item?.money ?? 0).currencyFormatting())đ - Lượt khach: \(item?.recordsCount ?? 0) "
    }
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        // Hide or do something when no column is selected
    }
    @IBAction func btnListInfoPressed(_ sender: UIButton) {
        let time = "\(dataSelect ?? "") 00:00:00"
        let miliseconds = Common.dateStringToMilis(dateString: time)
        actionViewList?(miliseconds ?? 0)
    }
    
    
}
