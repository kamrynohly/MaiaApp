//
//  QuestionTwoViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/22/21.
//

import UIKit
import MSCircularSlider

class QuestionTwoViewController: UIViewController {

    var valueArray = [Double]()
    
    @IBOutlet weak var sliderInput: MSCircularSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func submitPressed(_ sender: UIButton) {
        let num = Double(sliderInput.currentValue)
        valueArray.append(num)
        performSegue(withIdentifier: "toNextQuestion", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextQuestionPage = segue.destination as! QuestionThreeViewController
        nextQuestionPage.valueArray = valueArray
    }
    

}
