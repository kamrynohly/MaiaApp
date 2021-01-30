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
