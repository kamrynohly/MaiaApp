//
//  QuestionOneViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/22/21.
//

import UIKit
import MSCircularSlider

class QuestionOneViewController: UIViewController, MSCircularSliderDelegate {
    
    var valueArray = [Double]()

    @IBOutlet weak var sliderInput: MSCircularSlider!
    @IBOutlet weak var labelValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //not sure if I need to reset the array, but I think it's okay?
        labelValue.text = String(format: "%.1f", sliderInput.currentValue)
        sliderInput.delegate = self

    }
    
    
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        labelValue.text = String(format: "%.1f", value)
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let num = Double(sliderInput.currentValue)
        valueArray.append(num)
        performSegue(withIdentifier: "toNextQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextQuestionPage = segue.destination as! QuestionTwoViewController
        nextQuestionPage.valueArray = valueArray
    }
    
}
