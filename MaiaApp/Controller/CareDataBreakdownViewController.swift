//
//  CareDataBreakdownViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/29/21.
//

import UIKit
import Charts
//import CoreData
import Firebase

class CareDataBreakdownViewController: UIViewController {
    
    @IBOutlet weak var graphView: LineChartView!
   // var arrayOfUpdates = [Update]()
    var loaded = false
    var arrayOfUpdates = [DataUpdate]()
    var averagesArray = [Double]()
    var values0 = [Double]()
    var values1 = [Double]()
    var values2 = [Double]()
    var values3 = [Double]()
    var values4 = [Double]()
    var typesArr = ["Mental Health", "Family Relations", "Social Connections", "Physical Health", "Relaxation"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDataPoints()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 0.80, green: 0.93, blue: 0.96, alpha: 1.00).cgColor, UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAverages()
        updateChart()
        loaded = true
    }
    
    func getAverages() {
//        var total = 0.0
//        var numOfQuestions = 0.0
        for i in 0..<arrayOfUpdates.count {
            let item = arrayOfUpdates[i]
//            numOfQuestions = Double(item.numberOfQuestions)
            let arrayOfResponses : [Double] = item.arrayOfResponses as! [Double]
            for value in 0...4 {
                switch value {
                case 0:
                    values0.append(arrayOfResponses[value])
                    break
                case 1:
                    values1.append(arrayOfResponses[value])
                    break
                case 2:
                    values2.append(arrayOfResponses[value])
                    break
                case 3:
                    values3.append(arrayOfResponses[value])
                    break
                case 4:
                    values4.append(arrayOfResponses[value])
                    break
                default:
                    //
                    break
                }
//                total += arrayOfResponses[value]
            }
            
//            averagesArray.append(total/numOfQuestions)
//            total = 0.0
//            numOfQuestions = 0.0
        }
        print(averagesArray)
    }

    
    func updateChart() {
        if loaded {
            //do nothing
        }
        else {
            let dataStuff = LineChartData()
            var lineChartEntry = [ChartDataEntry]()
            var values = [values0, values1, values2, values3, values4]
            var colors = [NSUIColor.purple, NSUIColor.blue, NSUIColor.green, NSUIColor.yellow, NSUIColor.orange]
            
            for value in values {
                var currentIndex = values.firstIndex(of: value)
                lineChartEntry.removeAll()
                for i in 0..<value.count {
                    let info = ChartDataEntry(x: Double(i), y: value[i])
                    lineChartEntry.append(info)
                }
                let userLine = LineChartDataSet(entries: lineChartEntry, label: typesArr[currentIndex!])
                userLine.colors = [colors[currentIndex!]]
                userLine.mode = .cubicBezier
                userLine.cubicIntensity = 0.2
                userLine.drawCirclesEnabled = false
                
                dataStuff.addDataSet(userLine)
            }
    //        for i in 0..<averagesArray.count {
    //            let info = ChartDataEntry(x: Double(i), y: averagesArray[i])
    //            lineChartEntry.append(info)
    //        }
    //
    //        let userLine = LineChartDataSet(entries: lineChartEntry, label: "Averages")
    //        userLine.colors = [NSUIColor.purple]
    //        userLine.mode = .cubicBezier
    //        userLine.cubicIntensity = 0.2
    //        userLine.drawCirclesEnabled = false
    //
    //
    //
    //        dataStuff.addDataSet(userLine)
            
            graphView.drawGridBackgroundEnabled = false
            
            graphView.noDataText = "Oh no, it seems your data is not loading. Something may have gone wrong. Check back again later!"
            
            graphView.chartDescription?.text = "your stats"

            
            graphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
            graphView.xAxis.drawGridLinesEnabled = false
            graphView.leftAxis.drawGridLinesEnabled = false
            graphView.rightAxis.drawGridLinesEnabled = false
            graphView.xAxis.labelPosition = .bottom
            graphView.rightAxis.drawLabelsEnabled = false
            
            graphView.data = dataStuff
        }
    }
    
    func retrieveDataPoints() {
        
        let userID = Auth.auth().currentUser?.uid
        var dataRef = Database.database().reference().child("users").child(userID!).child("dataUpdates")

        dataRef.observe(.childAdded) { (snapshot) in

            let snapshotValue = snapshot.value as! NSArray
            
            if snapshotValue[0] != nil {
                let dataUpdate = DataUpdate()
                dataUpdate.numberOfQuestions = 8
              //  let valueOne = snapshotValue[0]

                for i in 0...7 {
                    dataUpdate.arrayOfResponses.append(snapshotValue[i] as! Double)
                }
                
                self.arrayOfUpdates.append(dataUpdate)
            }
            else {
                print("Something isn't working")
            }
        }
    }
    

    
}
