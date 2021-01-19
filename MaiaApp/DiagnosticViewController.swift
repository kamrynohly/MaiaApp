//
//  DiagnosticViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/18/21.
//

import UIKit
import Firebase
import FirebaseAuth

class DiagnosticViewController: UIViewController {

    @IBAction func goToDash(_ sender: Any) {
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userID = Auth.auth().currentUser?.uid
//        var ref : DatabaseReference!
//        ref = Database.database().reference().child("users").child(userID!).child("personalInfo")
//
        // Do any additional setup after loading the view.
       
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
