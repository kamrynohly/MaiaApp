//
//  SelfImprovementViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/26/21.
//

import UIKit
import Charts
//import CoreData
import Firebase

class SelfImprovementViewController: UIViewController {
    
    //var arrayOfUpdates = [Update]()
    var loaded = false
    var arrayOfUpdates = [DataUpdate]()
    var averagesArray = [Double]()
    var valuesDict = [String: Double]()
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var status: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveDataPoints()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 0.80, green: 0.93, blue: 0.96, alpha: 1.00).cgColor, UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAverages()
        updateChart()
        additionalSetUp()
        loaded = true
    }
    
    func getAverages() {
            var total = 0.0
            var numOfQuestions = 0.0
            for i in 0..<arrayOfUpdates.count {
                let item = arrayOfUpdates[i]
                numOfQuestions = Double(item.numberOfQuestions)
                let arrayOfResponses : [Double] = item.arrayOfResponses as! [Double]
                for value in 5...7 {
                    total += arrayOfResponses[value]
                }
                
                averagesArray.append(total/3)
                total = 0.0
                numOfQuestions = 0.0
            }
            print(averagesArray)
        }

        
        func updateChart() {
            if loaded {
                //do nothing
            }
            else {
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
    
    func additionalSetUp() {
        if averagesArray.count <= 1 {
            status.text = "Here's to new beginnings :)"
        } else {
            if averagesArray[averagesArray.count-1] > averagesArray[averagesArray.count-2] {
                status.text = "We've been doing better this week!!"
            } else {
                status.text = "We have some room for improvement this week, and that's okay!"
            }
        }
    }

}
