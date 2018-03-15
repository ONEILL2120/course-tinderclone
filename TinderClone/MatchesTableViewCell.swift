//
//  MatchesTableViewCell.swift
//  TinderClone-Swift
//
//  Created by Robert Oneill on 12/03/2018.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit

class MatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func send(_ sender: Any) {
        
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
