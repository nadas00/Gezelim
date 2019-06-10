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
    @IBOutlet weak var cardView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hide()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       cardView.layer.cornerRadius = 15
       
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowRadius = 2.0
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
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
