//
//  InsideCircleViewController.swift
//  MaiaApp
//
//  Created by Sofia Ongele on 1/21/21.
//

import UIKit
import Firebase

class InsideCircleViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    
    @IBOutlet weak var whichCircle: UINavigationItem!
    
    @IBAction func typeChanged(_ sender: Any) {
        retrievePosts()
        self.tableView.reloadData()
    }
    
    var typeIndex = 0
    var circleName = ""

    @IBOutlet weak var whichType: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated) // No need for semicolon
//        retrievePosts()
//    }
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("THE TYPE INDEX: " + String(typeIndex))
        print("THE CIRCLE NAME: " + circleName)
        whichType.selectedSegmentIndex = typeIndex
        whichCircle.title = circleName
        retrievePosts()
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        self.tableView.reloadData()
    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        retrievePosts()
        
    }
    
//    var noPosts: Bool
    var posts = [[String: Any]]()
    var types = ["Glows & Grows", "Resources", "Q & A"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        
        if posts.count == 0 {
            returnValue = 1
            print("NOTHING 2 SEE HERE")
        } else {
            returnValue = posts.count
            print(posts.count)
            print(posts)
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell: UITableViewCell
        
        if posts.count != 0 {
            switch(whichType.selectedSegmentIndex)
            {
            case 0:
                var cell = tableView.dequeueReusableCell(withIdentifier: "gloCell", for: indexPath) as! GloPostTableViewCell
                cell.username.text = posts[indexPath.row]["postBy"] as? String
                cell.subject.text = posts[indexPath.row]["subject"] as? String
                cell.desc.text = posts[indexPath.row]["desc"] as? String
                cell.postTime.text = posts[indexPath.row]["postTime"] as? String
                return cell
//                cell.textLabel!.text = privateList[indexPath.row]
                break
            case 1:
                var cell = tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath) as! RecPostTableViewCell
                cell.username.text = posts[indexPath.row]["postBy"] as? String
                cell.subject.text = posts[indexPath.row]["subject"] as? String
                cell.desc.text = posts[indexPath.row]["desc"] as? String
                cell.postTime.text = posts[indexPath.row]["postTime"] as? String
                return cell
                // insert link stuff here somehow
                break
                
            case 2:
                var cell = tableView.dequeueReusableCell(withIdentifier: "qaCell", for: indexPath) as! QAPostTableViewCell
                cell.username.text = posts[indexPath.row]["postBy"] as? String
                cell.subject.text = posts[indexPath.row]["subject"] as? String
                cell.desc.text = posts[indexPath.row]["desc"] as? String
                cell.postTime.text = posts[indexPath.row]["postTime"] as? String
                return cell
                break
                
            default:
                break
                
            }
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "noneCell", for: indexPath)
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var toReturn = 0
        if posts.count == 0 {
            toReturn = 101
        } else {
            toReturn = 142
        }
        return CGFloat(toReturn)
    }
    
    func retrievePosts() {
        posts.removeAll()
        let ref = Database.database().reference().child("circles")
        ref.observe(.value) { snapshot in
//            print(snapshot)
            // snapshot.childSnapshot(forPath: self.whichCircle.title!).value != nil
            let snapData = snapshot.value as! [String: Any]
            let circles = snapData["circles"]
//            print(snapData)
//            print(snapData[self.whichCircle.title!])
            if (snapData[self.whichCircle.title!] != nil) {
//                print("HI")
//                print("I WORK\nHIII")
//                let childSnap = snapshot.childSnapshot(forPath: self.whichCircle.title!)
                
                let childSnap = snapData[self.whichCircle.title!] as! [String: Any]
                if (childSnap[self.types[self.whichType.selectedSegmentIndex]] != nil) {
//                    print("HI")
//                    print("I WORK\nHIII")
                    let thePosts = childSnap[self.types[self.whichType.selectedSegmentIndex]]
//                    print(thePosts)
                    for child in thePosts as! [String: Any] {
                        var toAdd = child.value as? [String: Any] ?? [:]
                        var finalAdd = toAdd["postInfo"] as? [String: Any] ?? [:]
                        self.posts.append(finalAdd)
                        
                    }
                    self.tableView.reloadData()
                }
            }
            

          }
//        print(posts)
        self.refreshControl.endRefreshing()
//        self.tablactivityIndicatorView.stopAnimating()
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

class GloPostTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
}

class RecPostTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var star: UIButton!
    @IBAction func starred(_ sender: Any) {
        
    }
    
}

class QAPostTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
}
