//
//  QuestionOneViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/22/21.
//

import UIKit
import MSCircularSlider

class QuestionOneViewController: UIViewController {
    
    var valueArray = [Double]()

    @IBOutlet weak var sliderInput: MSCircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //not sure if I need to reset the array, but I think it's okay?
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
