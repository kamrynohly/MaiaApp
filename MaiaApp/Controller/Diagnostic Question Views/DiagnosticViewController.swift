//
//  DiagnosticViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/18/21.
//

import UIKit
import Firebase
import FirebaseAuth
import MSCircularSlider
import CoreData

class DiagnosticViewController: UIViewController, MSCircularSliderDelegate {
    
    var valueArray = [Double]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sliderInput: MSCircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // GREEN AND WHITE
        gradientLayer.colors = [UIColor(red: 0.82, green: 0.94, blue: 0.84, alpha: 1.00).cgColor, UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        sliderInput.delegate = self

       // print("\(valueArray) this works")
        valueLabel.text = String(format: "%.1f", sliderInput.currentValue)

    }
    
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        valueLabel.text = String(format: "%.1f", value)
    }
    
    func saveData() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context, \(error)")
        }
        
    }
    
    
    @IBAction func goToDash(_ sender: Any) {
        
        let num = Double(sliderInput.currentValue)
        valueArray.append(num)
        print(num)
        
        let newStatusUpdate = Update(context: self.context)
        newStatusUpdate.numberOfQuestions = 8
        newStatusUpdate.arrayOfResponses = valueArray as NSObject
        
        saveData()
        
        
        let data = DataUpdate()
        data.arrayOfResponses = valueArray
        data.numberOfQuestions = 8
        
        //Firebase implementation
        let userID = Auth.auth().currentUser?.uid
        //finds the user's name, used to confirm existence of user, no null value
        let infoReference = Database.database().reference().child("users").child(userID!).child("personalInfo")
                    
        var dataRef = Database.database().reference().child("users").child(userID!).child("dataUpdates")

        let date = Date()
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"

        // Convert Date to String
        let todaysDate = dateFormatter.string(from: date)
        
        
        infoReference.observe(.value) { (snapshot) in
            //snapshot should be formatted
            let snapshot = snapshot.value as? [String : String] ?? [:]

            dataRef.child(todaysDate).setValue(self.valueArray) {
                (error, reference) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Data update saved successfully.")
                }
            }
        }
        
    
        //go back to dashboard
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
    }
    
    

}
