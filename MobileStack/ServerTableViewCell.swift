//
//  ServerTableViewCell.swift
//  MobileStack
//
//  Created by Megan Dawn Kostick on 10/4/16.
//
//

import UIKit

class ServerTableViewCell: UITableViewCell {

    @IBOutlet weak var serverStatusImage: UIImageView!
    @IBOutlet weak var serverNameLabel: UILabel!
    @IBOutlet weak var serverIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
