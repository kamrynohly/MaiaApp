//
//  AnalyzeRantViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/29/21.
//

import UIKit
import ToneAnalyzer
import IBMSwiftSDKCore
import Assistant

class AnalyzeRantViewController: UIViewController {
    
    @IBOutlet weak var feelingLabel: UILabel!
    var rantText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        // main page gradient
        gradientLayer.colors = [UIColor(red: 1.00, green: 0.75, blue: 0.41, alpha: 1.00).cgColor, UIColor(red: 0.98, green: 0.70, blue: 0.87, alpha: 1.00).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        print(rantText)
        let authenticator = WatsonIAMAuthenticator(apiKey: "VR06UAdRPAQba1pLDDmN9BXnhQY_hhKklhElkzPTDOR4")
        let toneAnalyzer = ToneAnalyzer(version: "2018-12-31", authenticator: authenticator)
        toneAnalyzer.serviceURL = "https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/c74f01f5-a205-479f-a119-544857f188cf"
        
        let data = rantText
        
        toneAnalyzer.tone(toneContent: .text(data)) { (response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let tones = response?.result?.documentTone.tones else {
                print("Failed to analyze the tone input")
                return
            }
            
            var highestTone = ""
            var highestScore = 0.0
            for tone in tones {
                print("\(tone.toneName): \(tone.score)")
                if (tone.score > highestScore) {
                    highestScore = tone.score
                    highestTone = tone.toneName
                }
                self.feelingLabel.text = highestTone
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        let _ = navigationController?.popToRootViewController(animated: true)
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
