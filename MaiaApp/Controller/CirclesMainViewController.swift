//
//  CirclesMainViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/28/21.
//

import UIKit

class CirclesMainViewController: UIViewController {

    @IBAction func finance(_ sender: Any) {
        if (glo.isHidden == true) {
            glo.isHidden = false
            resources.isHidden = false
            qna.isHidden = false
        } else {
            glo.isHidden = true
            resources.isHidden = true
            qna.isHidden = true
        }
    }
    @IBOutlet weak var glo: RoundButton!
    @IBOutlet weak var resources: RoundButton!
    @IBOutlet weak var qna: RoundButton!
    
    var typeIndex = 0
    var circleName = ""

    
    @IBAction func education(_ sender: Any) {
        if (glo2.isHidden == true) {
            glo2.isHidden = false
            resources2.isHidden = false
            qna2.isHidden = false
        } else {
            glo2.isHidden = true
            resources2.isHidden = true
            qna2.isHidden = true
        }
    }
    @IBOutlet weak var glo2: RoundButton!
    @IBOutlet weak var resources2: RoundButton!
    @IBOutlet weak var qna2: RoundButton!
    
    @IBAction func fitness(_ sender: Any) {
        if (glo3.isHidden == true) {
            glo3.isHidden = false
            resources3.isHidden = false
            qna3.isHidden = false
        } else {
            glo3.isHidden = true
            resources3.isHidden = true
            qna3.isHidden = true
        }
    }
    @IBOutlet weak var glo3: RoundButton!
    @IBOutlet weak var resources3: RoundButton!
    @IBOutlet weak var qna3: RoundButton!
    
    @IBAction func goToCircle(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            circleName = "Finance"
            if sender == glo {
                typeIndex = 0
            } else if sender == resources {
                typeIndex = 1
            } else {
                typeIndex = 2
            }
            break
        case 2:
            circleName = "Education"
            if sender == glo2 {
                typeIndex = 0
            } else if sender == resources2 {
                typeIndex = 1
            } else {
                typeIndex = 2
            }
            break
        case 3:
            circleName = "Fitness"
            if sender == glo3 {
                typeIndex = 0
            } else if sender == resources3 {
                typeIndex = 1
            } else {
                typeIndex = 2
            }
            break
        default:
            return
        }
        self.performSegue(withIdentifier: "toCircles", sender: self)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toCircles" {
            let vc = segue.destination as! InsideCircleViewController
            vc.circleName = circleName
            vc.typeIndex = typeIndex
            
            print("HEY I EXIST")
                
                
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        glo.tag = 1
//        resources.tag = 1
//        qna.tag = 1
//
//        glo2.tag = 2
//        resources2.tag = 2
//        qna2.tag = 2
//
//        glo3.tag = 3
//        resources3.tag = 3
//        qna3.tag = 3
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
