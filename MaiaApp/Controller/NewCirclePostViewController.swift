//
//  NewCirclePostViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/21/21.
//

import UIKit
import Firebase


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
        if checkCompleteness() {
            let userID = Auth.auth().currentUser?.uid
            let infoReference = Database.database().reference().child("users").child(userID!).child("personalInfo")
            let globalPostReference = Database.database().reference().child("circles").child(circleToPost.text!).child(typePost.text!)
            let localPostReference = Database.database().reference().child("users").child(userID!).child("circles").child(circleToPost.text!).child(typePost.text!)
            infoReference.observe(.value) { (snapshot) in
                //snapshot should be formatted
                let snapshot = snapshot.value as? [String : String] ?? [:]
                var nameOfMainUser = ""
                
                if snapshot["username"] != nil {
                    nameOfMainUser = String(snapshot["username"]!)
                }
                else {
                    nameOfMainUser = "Error loading name"
                }
                
                
                let localPostIDReference = localPostReference.childByAutoId()
                let randomIDKey = String(localPostIDReference.key!)
                let timestamp = NSDate().timeIntervalSince1970
                
                //this is the main information saved to both the user's local reference, and then globally
                var postDictionary: [String: Any]
                if self.typePost.text != "Resources" {
                    postDictionary = ["postBy": nameOfMainUser, "subject": self.subject.text!, "desc": self.desc.text!, "senderID": userID!, "postID": randomIDKey, "postTime": timestamp]
                } else {
                    postDictionary = ["postBy": nameOfMainUser, "subject": self.subject.text!, "desc": self.desc.text!, "senderID": userID!, "postID": randomIDKey, "link": self.website.text!, "postTime": timestamp]
                }
                
                
                localPostIDReference.setValue(postDictionary) {
                    (error, reference) in
                    
                    if error != nil {
                        print(error!)
                    }
                    else {
                        print("Event saved successfully to local ref.")
                    }
                }
                globalPostReference.child(randomIDKey).child("postInfo").setValue(postDictionary) {
                    (error, reference) in
                    if error != nil {
                        print(error!)
                    }
                    else {
                        print("Event saved successfully to global ref.")
                    }
                }
            }
            
            
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        let circlePicker = UIPickerView()
        circlePicker.tag = 0
        let typePicker = UIPickerView()
        typePicker.tag = 1
        circleToPost.inputView = circlePicker
        typePost.inputView = typePicker
        
        circlePicker.delegate = self
        circlePicker.dataSource = self
//        circlePicker.showsSelectionIndicator = true
        
        typePicker.delegate = self
        typePicker.dataSource = self
//        typePicker.showsSelectionIndicator = true
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
        } else {
            complete = true
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
