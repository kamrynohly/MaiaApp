//
//  QuestionSevenViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/22/21.
//

import UIKit
import MSCircularSlider

class QuestionSevenViewController: UIViewController, MSCircularSliderDelegate{
    
    var valueArray = [Double]()

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var sliderInput: MSCircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderInput.delegate = self
        valueLabel.text = String(format: "%.1f", sliderInput.currentValue)

    }
    
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        valueLabel.text = String(format: "%.1f", value)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let num = Double(sliderInput.currentValue)
        valueArray.append(num)
        performSegue(withIdentifier: "toNextQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextQuestionPage = segue.destination as! DiagnosticViewController
        nextQuestionPage.valueArray = valueArray
    }
    

}
