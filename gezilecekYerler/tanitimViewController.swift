//
//  tanitimViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 4.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    
    
    
    
     var ref: DatabaseReference!
     var databaseHandle:DatabaseHandle?
     var postData = ""
    
//    var GezilecekYerBasliklari = [String]()
//    var resim1 = UIImage()
//    var baslik1=""
//    var aciklama1=""
    var secilmisGezilecekYer = 0
    var secilmisSehir = 0

    override func viewDidLoad() {
        super.viewDidLoad()
          addNavBarImage()
        
        //set firebase reference
         ref = Database.database().reference()
         //retrieve post and listen for changes
        ref?.child(String(secilmisSehir)).child("tripLocations").child(String(secilmisGezilecekYer)).child("description").observe(.value, with: { (snapshot) in
            
           
             //code to execute when a child added under Posts
            let post = snapshot.value as? String
                        if let actualPost = post{
                            self.postData=actualPost
                            print(actualPost)
                           
                           
                        }
                    })

      
        self.baslik.text="dasasd"

      
    
       
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
