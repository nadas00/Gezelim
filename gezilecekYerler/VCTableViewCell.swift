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
    @IBOutlet weak var ImageView: UIView!
    
    @IBOutlet weak var RightView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layer.backgroundColor = UIColor.clear.cgColor
        hide()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     
       
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowRadius = 2.0
  
    }
   
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        //hücrenin belli yerlerini yuvarlatmak için kullanılan fonksiyon //extension olarak tanımlandı
        
      // cardView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
    
         
      
  /* ImageView.roundCorners(corners:[.topLeft, .bottomLeft, .topRight, .bottomRight], radius: 180)
        */
        
        // hücreyi daraltmak için kullanılan fonksiyon
        
       
 contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
 
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
    }
    func animate() {
        
        UIView.beginAnimations("", context: nil)
        
        UIView.setAnimationDuration(0.7)
        layer.transform = CATransform3DIdentity
        alpha = 1
        
        UIView.commitAnimations()
        
    }
    
    func hide() {
        
        alpha = 0
        
      layer.transform = CATransform3DMakeRotation((30  * .pi) / 90 , 0, 0.5, 0)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
 
        
        //  layer.transform = CATransform3DMakeRotation((90 * .pi) / 30, 1, 0, 0) layer.anchorPoint = CGPoint(x: 0, y: 0.5) : takla
        
        // yay layer.transform = CATransform3DMakeRotation((30  * .pi) / 90 , 0, 0.5, 0)
        //yay layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
    }

}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
