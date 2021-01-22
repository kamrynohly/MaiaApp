//
//  SettingsViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/18/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        do {
                   try Auth.auth().signOut()
               }
            catch let signOutError as NSError {
                   print ("Error signing out: %@", signOutError)
               }
               
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let initial = storyboard.instantiateInitialViewController()
               UIApplication.shared.keyWindow?.rootViewController = initial
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
