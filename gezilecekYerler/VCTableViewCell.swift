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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hide()
    }
    
    func animate() {
        
        UIView.beginAnimations("", context: nil)
        
        UIView.setAnimationDuration(0.5)
        layer.transform = CATransform3DIdentity
        alpha = 1
        
        UIView.commitAnimations()
        
    }
    
    func hide() {
        
        alpha = 0
        
        layer.transform = CATransform3DMakeRotation((90.0 * .pi) / 180, 0.3, 0, 0.1)
        layer.anchorPoint = CGPoint(x: 0, y: 0.5)
    }

}
