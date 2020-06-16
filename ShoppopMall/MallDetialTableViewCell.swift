//
//  SonicpMallDetialTableViewCell.swift
//  SonicpMall
//
//  Created by 潘子文 on 2020/6/5.
//  Copyright © 2020 潘子文. All rights reserved.
//

import UIKit

class MallDetialTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImagevView: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
