//
//  LogInViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/15/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        //TODO: Login the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
                
                let alert = UIAlertController(title: "Please Try Again", message: "Incorrect email or password.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Okay", style: .cancel) { (action) in
                    print("Okay Pressed")
                }
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                

                let userID = Auth.auth().currentUser?.uid
                let ref = Database.database().reference().child("users").child(userID!).child("personalInfo")
                
                ref.observe(.value) { (snapshot) in
                    let snapshotThing = snapshot.value as? [String : String] ?? [:]
                    if snapshotThing["username"] != nil {
                        print("Login Successful")
                        self.performSegue(withIdentifier: "successfulLogIn", sender: self)
                    }
                    else {
                        print("Problem")
                    }
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
