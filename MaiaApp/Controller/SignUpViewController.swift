//
//  SignUpViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/15/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpw: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if password.text != confirmpw.text {
                    let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
        else {
            Auth.auth().createUser(withEmail: email.text!, password: confirmpw.text!) { (user, error) in
                        
                        if error != nil {
                            print(error!)
                            let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                                
                                                alertController.addAction(defaultAction)
                                                self.present(alertController, animated: true, completion: nil)
                        }
                        else {
                            //success
                            print("Registration Successful")
                            
                            let userID = Auth.auth().currentUser?.uid
                            var ref : DatabaseReference!
                            ref = Database.database().reference().child("users").child(userID!).child("personalInfo")
                            let infoDict : [String : Any] = ["username" : self.username.text!]
                            ref.setValue(infoDict)
                            
                            //for creation of goals data location
                            var goalsRef = Database.database().reference().child("users").child(userID!).child("goals")
                           
                            
                            self.performSegue(withIdentifier: "successSignUp", sender: self)
                            
                        }
                        
                    }
            }
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
