//
//  NewCirclePostViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/21/21.
//

import UIKit

class NewCirclePostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var circles = ["Finance", "Education", "Fitness"]
    var types = ["Glows & Grows", "Resources", "Q & A"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return circles[row]
        } else if pickerView.tag == 1 {
            return types[row]
        }
        return ""
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            circleToPost.text = circles[row]
        } else if pickerView.tag == 1 {
            typePost.text = types[row]
        }
    }
    

    @IBOutlet weak var circleToPost: UITextField!
    @IBOutlet weak var typePost: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var website: UITextField!
    
    @IBAction func submitPost(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let circlePicker = UIPickerView()
        circlePicker.tag = 0
        let typePicker = UIPickerView()
        typePicker.tag = 1
        circleToPost.inputView = circlePicker
        typePost.inputView = typePicker
        // Do any additional setup after loading the view.
    }
    // MARK: SOFIA PICK UP HERE
    func checkCompleteness() -> Bool {
            var complete = false
        if (circleToPost.text == "" || typePost.text == "" || subject.text == "" || desc.text == "") {
            let alertPrompt = UIAlertController(title: "oops!", message: "you didn't finish filling out the form!", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "let me fix it!", style: UIAlertAction.Style.cancel, handler: nil)
                        
            alertPrompt.addAction(confirmAction)
                        
            present(alertPrompt, animated: true, completion: nil)
        } else if (website.text == "" && typePost.text == "Resources") {
            let alertPrompt = UIAlertController(title: "oops!", message: "you didn't finish filling out the form!", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "let me fix it!", style: UIAlertAction.Style.cancel, handler: nil)
                        
            alertPrompt.addAction(confirmAction)
                        
            present(alertPrompt, animated: true, completion: nil)
        }
            return complete
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
