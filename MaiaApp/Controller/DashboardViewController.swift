//
//  DashboardViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/15/21.
//

import UIKit
import Charts
import CoreData

class DashboardViewController: UIViewController {

    var arrayOfUpdates = [Update]()
    var averagesArray = [Double]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var graphView: LineChartView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        getAverages()
        updateChart()
    }
    
    func getAverages() {
        var total = 0.0
        var numOfQuestions = 0.0
        for i in 0..<arrayOfUpdates.count {
            let item = arrayOfUpdates[i]
            numOfQuestions = Double(item.numberOfQuestions)
            let arrayOfResponses : [Double] = item.arrayOfResponses! as! [Double]
            for value in arrayOfResponses{
                total += value
            }
            
            averagesArray.append(total/numOfQuestions)
            total = 0.0
            numOfQuestions = 0.0
        }
        print(averagesArray)
    }
    
    func loadData(with request : NSFetchRequest<Update> = Update.fetchRequest()) {
        do {
            arrayOfUpdates = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context, \(error)")
        }
        
    }
    
    func updateChart() {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<averagesArray.count {
            let info = ChartDataEntry(x: Double(i), y: averagesArray[i])
            lineChartEntry.append(info)
        }
        
        let userLine = LineChartDataSet(entries: lineChartEntry, label: "Averages")
        userLine.colors = [NSUIColor.purple]
        userLine.mode = .cubicBezier
        userLine.cubicIntensity = 0.2
        userLine.drawCirclesEnabled = false


        let dataStuff = LineChartData()
        dataStuff.addDataSet(userLine)

        graphView.drawGridBackgroundEnabled = false
       
        graphView.noDataText = "Oh no, it seems your data is not loading. Something may have gone wrong. Check back again later!"

        graphView.chartDescription?.text = "this works!"
        
        graphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        graphView.xAxis.drawGridLinesEnabled = false
        graphView.leftAxis.drawGridLinesEnabled = false
        graphView.rightAxis.drawGridLinesEnabled = false
        graphView.xAxis.labelPosition = .bottom
        graphView.rightAxis.drawLabelsEnabled = false

        graphView.data = dataStuff
    }

    
    @IBAction func goToDiagnostic(_ sender: Any) {
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiagnosticNavigationController") as? UINavigationController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
    }

    

}