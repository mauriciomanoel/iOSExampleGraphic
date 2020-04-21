//
//  ViewController.swift
//  ExampleGraphic
//
//  Created by Mauricio on 4/17/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    @IBOutlet weak var combinedChart: CombinedChartView!
    
    var chart: CombinedChartView!
    var lineDataSet: LineChartDataSet!
    var barDataSet: BarChartDataSet!
    let activities = ["Início", "2020"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupChart()
        
    }
    
    func setupChart() {
        
//        combinedChart.backgroundColor = UIColor
        combinedChart.backgroundColor = UIColor().colorFromHexString("ffffff")
        
        let combinedData = CombinedChartData()
        combinedData.barData = generateBarData()
        combinedData.lineData = generateLineData()
        
        let legend = combinedChart.legend
        //legend.isWordWrapEnabled = true
        legend.verticalAlignment = Legend.VerticalAlignment.top
        legend.horizontalAlignment = Legend.HorizontalAlignment.center
        legend.orientation = Legend.Orientation.horizontal
        legend.drawInside = false
        
        // set right and left axis
        combinedChart.leftAxis.axisMinimum = 0.0
        combinedChart.leftAxis.drawGridLinesEnabled = false
        combinedChart.rightAxis.axisMinimum = 0.0
        combinedChart.rightAxis.drawGridLinesEnabled = false
        
        // set x-axis labels
        let xAxis = combinedChart.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.labelRotationAngle = -30
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 1.5
        xAxis.valueFormatter = self

        
        //xAxis.valueFormatter
        
       
        let data = combinedData
        
        xAxis.axisMaximum = data.xMax + 1.0
        xAxis.axisMinimum = data.xMin - 0.5
        
        
        combinedChart.leftAxis.axisMaximum = data.getYMax() + 100
        combinedChart.rightAxis.axisMaximum = data.getYMax() + 1

        
        combinedChart.data = data
    }
    
    
    func generateBarData() -> BarChartData
    {
        let values: [Double] = [8, 104, 81, 93, 52, 44, 97, 101, 75]

        var entries: [ChartDataEntry] = Array()

//        for (i, value) in values.enumerated()
//        {
//
//            entries.append(BarChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
//        }

        entries.append(BarChartDataEntry(x: 0.0, yValues: [0.0,0.0]))
        entries.append(BarChartDataEntry(x: 1.0, yValues: [26027.22,1500]))

        
        barDataSet = BarChartDataSet(entries: entries, label: "")
        barDataSet.stackLabels = ["Principal", "Interest"]
        barDataSet.setColors([UIColor().colorFromHexString("fccf7f"), UIColor().colorFromHexString("fca000")], alpha: 1)
        barDataSet.axisDependency = YAxis.AxisDependency.left
        barDataSet.drawIconsEnabled = false

        let data = BarChartData(dataSet: barDataSet)
        data.barWidth = 0.85
        return data
    }

    func generateLineData() -> LineChartData
    {
        let values: [Double] = [25000, 0]

        var entries: [ChartDataEntry] = Array()

        for (i, value) in values.enumerated()
        {
            entries.append(ChartDataEntry(x: Double(i), y: value, icon: UIImage(named: "icon", in: Bundle(for: self.classForCoder), compatibleWith: nil)))
        }

        lineDataSet = LineChartDataSet(entries: entries, label: "Balance")
        lineDataSet.setColor(UIColor().colorFromHexString("3d70b2"))
        lineDataSet.lineWidth = 2.5
        lineDataSet.setCircleColor(UIColor().colorFromHexString("3d70b2"))
        lineDataSet.drawIconsEnabled = false
        return LineChartData(dataSet: lineDataSet)
    }

    


}

extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

