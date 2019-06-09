//
//  VCTableViewCell.swift
//  gezilecekYerler
//
//  Created by gofret on 9.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class VCTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCell: UILabel!
    
    @IBOutlet weak var ImageCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
