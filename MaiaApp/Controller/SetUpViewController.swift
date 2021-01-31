//
//  SetUpViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/18/21.
//

import UIKit

class SetUpViewController: UIViewController {

    @IBOutlet weak var slider: UISwitch!
    
    @IBAction func goToDiagnostic(_ sender: Any) {
        if let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiagnosticNavigationController") as? UINavigationController
        {
            home.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()?.present(home, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 0.83, green: 0.76, blue: 0.84, alpha: 1.00).cgColor,UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00).cgColor ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        //asks for permission to send reminders
        if slider.isOn {
            let center = UNUserNotificationCenter.current()

            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                //hopefully they grant permission
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
