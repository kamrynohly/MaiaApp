//
//  RantViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/29/21.
//

import UIKit

class RantViewController: UIViewController {

    @IBOutlet weak var rantBox: UITextView!
    
    @IBAction func sendText(_ sender: Any) {
        if rantBox.text == "" {
            // alert
        } else {
            // send text to next
//            let viewControllerB = AnalyzeRantViewController()
//            viewControllerB.rantText = rantBox.text
//            navigationController?.pushViewController(viewControllerB, animated: true)
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 1.00, green: 0.75, blue: 0.41, alpha: 1.00).cgColor, UIColor(red: 0.98, green: 0.70, blue: 0.87, alpha: 1.00).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = segue.destination as! AnalyzeRantViewController
            controller.rantText = rantBox.text
            
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
