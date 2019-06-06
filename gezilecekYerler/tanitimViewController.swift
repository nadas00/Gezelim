//
//  tanitimViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 4.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class tanitimViewController: UIViewController {
    func addNavBarImage() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "topBanner.png") //Your logo url here
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    
    
    
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var baslik: UILabel!
    @IBOutlet weak var aciklama: UITextView!
    
    
    
    
    var GezilecekYerBasliklari = [String]()
    var resim1 = UIImage()
    var baslik1=""
    var aciklama1=""

    override func viewDidLoad() {
        super.viewDidLoad()
          addNavBarImage()

        resim.image=resim1
        baslik.text=baslik1
        aciklama.text=aciklama1
        aciklama.isEditable=false
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
