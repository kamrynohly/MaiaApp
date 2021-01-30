//
//  SelfCareViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/29/21.
//

import UIKit
import Charts
import CoreData

class SelfCareViewController: UIViewController {
        var arrayOfUpdates = [Update]()
        var averagesArray = [Double]()
        var valuesDict = [String: Double]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        @IBOutlet weak var status: UILabel!
        @IBOutlet weak var graphView: LineChartView!
        
        
        @objc func someAction(_ sender:UITapGestureRecognizer){
            performSegue(withIdentifier: "toBreakdown", sender: self)
        }
        
    
       
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadData()
            getAverages()
            updateChart()
            
            let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
            self.graphView.addGestureRecognizer(gesture)
            
            if averagesArray[averagesArray.count-1] > averagesArray[averagesArray.count-2] {
                status.text = "We've been doing better this week!!"
            } else {
                status.text = "We have some room for improvement this week, and that's okay!"
            }
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.view.bounds
            // main page gradient
            gradientLayer.colors = [UIColor(red: 0.80, green: 0.93, blue: 0.96, alpha: 1.00).cgColor, UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor ]
            self.view.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        func getAverages() {
            var total = 0.0
            var numOfQuestions = 0.0
            for i in 0..<arrayOfUpdates.count {
                let item = arrayOfUpdates[i]
                numOfQuestions = Double(item.numberOfQuestions)
                let arrayOfResponses : [Double] = item.arrayOfResponses! as! [Double]
                for value in 0...4 {
                    total += arrayOfResponses[value]
                }
                
                averagesArray.append(total/5)
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

        


}
