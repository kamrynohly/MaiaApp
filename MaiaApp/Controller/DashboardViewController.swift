//
//  DashboardViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/15/21.
//

import UIKit
import Charts
//import CoreData
import Firebase

class DashboardViewController: UIViewController {

    //var arrayOfUpdates = [Update]()
    var arrayOfUpdates = [DataUpdate]()
    var loaded = false
    var averagesArray = [Double]()
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //notification center
    let center = UNUserNotificationCenter.current()

    
    @IBOutlet weak var graphView: LineChartView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveDataPoints()

        //setting up reminders
        let content = UNMutableNotificationContent()
        content.title = "Hey, it's Maia!"
        content.body = "You haven't checked in a while, so we wanted to check on you!"
        
        //this is in seconds
        //a day has 86,400 seconds
        //a week has 604,800 seconds
        //currently a notification after 600 seconds of exiting the app, only one until they re-open
        //this means that 10 minutes after opening the dashboard, it'll send a reminder (for testing purposes of course)!
       let date = Date().addingTimeInterval(60)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        //usually set to false for repeats
       let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //idk what this is?
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            //something went wrong
        }
        //end of code for reminders
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 0.80, green: 0.93, blue: 0.96, alpha: 1.00).cgColor, UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAverages()
        updateChart()
        loaded = true
    }
    
    func retrieveDataPoints() {
        
        let userID = Auth.auth().currentUser?.uid
        var dataRef = Database.database().reference().child("users").child(userID!).child("dataUpdates")
        
        dataRef.observe(.childAdded) { (snapshot) in

            let snapshotValue = snapshot.value as! NSArray
            
            if snapshotValue[0] != nil {
                let dataUpdate = DataUpdate()
                dataUpdate.numberOfQuestions = 8

                for i in 0...7 {
                    dataUpdate.arrayOfResponses.append(snapshotValue[i] as! Double)
                }
                
//                print(dataUpdate.arrayOfResponses)
                self.arrayOfUpdates.append(dataUpdate)
               

            }
            else {
                print("Something isn't working")
            }
        }
    }
    
    
//    func getAverages() {
//        var total = 0.0
//        var numOfQuestions = 0.0
//        for i in 0..<arrayOfUpdates.count {
//            let item = arrayOfUpdates[i]
//            numOfQuestions = Double(item.numberOfQuestions)
//            let arrayOfResponses : [Double] = item.arrayOfResponses! as! [Double]
//            for value in arrayOfResponses{
//                total += value
//            }
//
//            averagesArray.append(total/numOfQuestions)
//            total = 0.0
//            numOfQuestions = 0.0
//        }
//        print(averagesArray)
//    }
    
        func getAverages() {
            var total = 0.0
            var numOfQuestions = 8.0
            for i in 0..<arrayOfUpdates.count {
                let item = arrayOfUpdates[i]
                numOfQuestions = Double(item.numberOfQuestions)
                let arrayOfResponses : [Double] = item.arrayOfResponses as! [Double]
                for value in arrayOfResponses{
                    total += value
                }
    
                averagesArray.append(total/numOfQuestions)
                total = 0.0
                numOfQuestions = 0.0
            }
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

    
    @IBAction func goToDiagnostic(_ sender: Any) {
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiagnosticNavigationController") as? UINavigationController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
    }

    

}
