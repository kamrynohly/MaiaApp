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
        
        //go back to dashboard
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
    }
    
    

}
