//
//  DashboardViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/15/21.
//

import UIKit
import Charts

class DashboardViewController: UIViewController {

    @IBOutlet weak var graphView: LineChartView!
    
    //either grab from Core Data or database
    var selfCareData = [2.0, 4.5, 7.5, 10.0, 10.0, 2.0, 7.0, 8.0, 6.5]
    var selfImprovementData = [8.0, 6.5, 4.0, 8.0, 7.5, 6.0, 8.0, 7.0]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        updateChart()
        // Do any additional setup after loading the view.
    }
    
    func updateChart() {
        var lineChartEntry = [ChartDataEntry]()

        for i in 0..<selfCareData.count {
            let info = ChartDataEntry(x: Double(i), y: selfCareData[i])
            lineChartEntry.append(info)
        }
        
        let line = LineChartDataSet(entries: lineChartEntry, label: "Self Care over Time")
        line.colors = [NSUIColor.purple]
        
        let dataStuff = LineChartData()
        dataStuff.addDataSet(line)
    
        
        var lineChartEntry2 = [ChartDataEntry]()
        for i in 0..<selfImprovementData.count {
            let info = ChartDataEntry(x: Double(i), y: selfImprovementData[i])
            lineChartEntry2.append(info)
        }
        
       let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Self Improvement over Time")
        line2.colors = [NSUIColor.green]
        dataStuff.addDataSet(line2)
        line.mode = .cubicBezier
        line2.mode = .cubicBezier
        
        graphView.data = dataStuff
        graphView.chartDescription?.text = "Track your progress! Click for details"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
