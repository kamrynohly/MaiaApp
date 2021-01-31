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
        hideKeyboardWhenTappedAround()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 0.82, green: 0.94, blue: 0.84, alpha: 1.00).cgColor,  UIColor(red: 0.80, green: 0.93, blue: 0.96, alpha: 1.00).cgColor, UIColor(red: 0.83, green: 0.76, blue: 0.84, alpha: 1.00).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)

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
                        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
                        {
                            home.modalPresentationStyle = .fullScreen
                            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
                        }
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

