//
//  TableViewCell.swift
//  GoalTracker
//
//  Created by Kamryn Ohly on 1/26/21.
//

import UIKit

class GoalTableViewCell: UITableViewCell {

    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var goalDescription: UILabel!
    @IBOutlet weak var latestDescription: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var loadHistory: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var circle: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
