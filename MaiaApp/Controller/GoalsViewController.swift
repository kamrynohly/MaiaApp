//
//  GoalsViewController.swift
//  MaiaApp
//
//  Created by Kamryn Ohly on 1/26/21.
//

import UIKit
import Firebase

class GoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var goalsArray : [Goal] = [Goal]()
    var isTableEmpty = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveGoals()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customTableViewCell")

        tableView.reloadData()
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell", for: indexPath) as! GoalTableViewCell
        
        if goalsArray.count == 0 {
               cell.goalTitle.text = "No goals... yet!"
               cell.goalDescription.isHidden = true
            
            //for future iterations
            cell.dateLabel.isHidden = true
            cell.latestDescription.isHidden = true
            cell.bottomView.isHidden = true
            cell.addUpdateButton.isHidden = true
            cell.loadHistory.isHidden = true
            cell.progressLabel.isHidden = true
            cell.circle.isHidden = true
           }
           else {
            cell.dateLabel.isHidden = false
            cell.latestDescription.isHidden = false
            cell.goalDescription.isHidden = false
            cell.circle.isHidden = false
            
            //for future iterations
            cell.bottomView.isHidden = true
            cell.addUpdateButton.isHidden = true
            cell.loadHistory.isHidden = true
            cell.progressLabel.isHidden = true

            
            let goal = goalsArray[indexPath.row]

            cell.goalTitle.text = goal.title
            cell.goalDescription.text = goal.description
            }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goalsArray.count == 0 {
            isTableEmpty = true
            return 1
        }
        else {
            isTableEmpty = false
            return goalsArray.count
        }
    }

    func retrieveGoals() {
        
        let userID = Auth.auth().currentUser?.uid
       let ref = Database.database().reference().child("users").child(userID!).child("goals")
        
        ref.observe(.childAdded) { (snapshot) in

            let snapshotValue = snapshot.value as? [String: String] ?? [:]

            if snapshotValue["title"] != nil {

                let title = String(snapshotValue["title"]!)
                let description = String(snapshotValue["description"]!)


                let goal = Goal()
                goal.title = title
                goal.description = description

                self.goalsArray.append(goal)
                self.tableView.reloadData()
            }
            else {
                print("Something isn't working")
            }
        }
    }
    
    @IBAction func addGoal(_ sender: UIButton) {
        
        
    }
    
}
