//
//  AddGoalViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/26/21.
//

import UIKit
import Firebase

class AddGoalViewController: UIViewController {

    @IBOutlet weak var goalTitleLabel: UITextField!
    
    @IBOutlet weak var goalDescription: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

    }
    
    @IBAction func createGoal(_ sender: UIButton) {
        
        let userID = Auth.auth().currentUser?.uid
        //finds the user's name, used to confirm existence of user, no null value
        let infoReference = Database.database().reference().child("users").child(userID!).child("personalInfo")
                    
        let goalsReference = Database.database().reference().child("users").child(userID!).child("goals")
        
        

        infoReference.observe(.value) { (snapshot) in
            //snapshot should be formatted
            let snapshot = snapshot.value as? [String : String] ?? [:]
            var numberOfGoals = 0

            if snapshot["numberOfGoals"] != nil {
                numberOfGoals = Int(snapshot["numberOfGoals"]!)!
            }
            else {
                print("did not load")
            }


            //creates goal dictionary
            let goal = ["title": self.goalTitleLabel.text!, "description": self.goalDescription.text!]
            let newGoalRef = goalsReference.childByAutoId()

            newGoalRef.setValue(goal) {
                (error, reference) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Goal saved successfully.")
                }
            }
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
}
