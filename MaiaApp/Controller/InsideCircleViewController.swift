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
    

    @IBOutlet weak var whichType: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
//    override func viewWillAppear() {
//
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
//                cell.textLabel!.text = privateList[indexPath.row]
                break
            case 1:
                var cell = tableView.dequeueReusableCell(withIdentifier: "recCell", for: indexPath) as! RecPostTableViewCell
                cell.username.text = posts[indexPath.row]["postBy"] as? String
                cell.subject.text = posts[indexPath.row]["subject"] as? String
                cell.desc.text = posts[indexPath.row]["desc"] as? String
                cell.postTime.text = posts[indexPath.row]["postTime"] as? String
                // insert link stuff here somehow
                break
                
            case 2:
                var cell = tableView.dequeueReusableCell(withIdentifier: "qaCell", for: indexPath) as! QAPostTableViewCell
                cell.username.text = posts[indexPath.row]["postBy"] as? String
                cell.subject.text = posts[indexPath.row]["subject"] as? String
                cell.desc.text = posts[indexPath.row]["desc"] as? String
                cell.postTime.text = posts[indexPath.row]["postTime"] as? String
                break
                
            default:
                break
                
            }
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "noneCell", for: indexPath)
        }
        return UITableViewCell()
    }
    
    func retrievePosts() {
        posts.removeAll()
        let ref = Database.database().reference().child("circles")
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            print(snapshot)
            if (snapshot.childSnapshot(forPath: self.whichCircle.title!).value != nil) {
                print("HI")
                print("I WORK\nHIII")
                let childSnap = snapshot.childSnapshot(forPath: self.whichCircle.title!)
                if (childSnap.childSnapshot(forPath: self.types[self.whichType.selectedSegmentIndex]).value != nil) {
                    print("HI")
                    print("I WORK\nHIII")
                    let thePosts = childSnap.childSnapshot(forPath: self.types[self.whichType.selectedSegmentIndex])
                    for child in thePosts.children.allObjects as! [DataSnapshot] {
                        
                        var toAdd = child.value as? [String: Any] ?? [:]
                        self.posts.append(toAdd)
                    }
                }
            }
          })
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
    
}

class QAPostTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var postTime: UILabel!
    
}
