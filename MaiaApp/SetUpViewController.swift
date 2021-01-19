//
//  SetUpViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/18/21.
//

import UIKit

class SetUpViewController: UIViewController {

    @IBAction func goToDiagnostic(_ sender: Any) {
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiagnosticNavigationController") as? UINavigationController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
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
