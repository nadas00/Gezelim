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
    
    
  
    
    @IBOutlet weak var baslik: UILabel!
    @IBOutlet weak var aciklama: UITextView!
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var topicData = ""
    var descriptionData = ""
    var secilmisGezilecekYer = 0
    var secilmisSehir = 0

    override func viewDidLoad() {
        super.viewDidLoad()
          addNavBarImage()
        
        //set firebase reference
         ref = Database.database().reference()
         //retrieve post and listen for changes
        ref?.child("cities").child(String(secilmisSehir)).child("tripLocations").child(String(secilmisGezilecekYer)).observe(.value, with: { (snapshot) in
            
           
             //code to execute when a child added under Posts
            let topic = snapshot.childSnapshot(forPath: "locationName").value as? String
                        if let actualPost = topic{
                            self.topicData=actualPost
                            print(actualPost)
                            self.baslik.text=self.topicData
                           
                        }
            
            //code to execute when a child added under Posts
              let description = snapshot.childSnapshot(forPath: "description").value as? String
                          if let actualPost = description{
                              self.descriptionData=actualPost
                              print(actualPost)
                              self.aciklama.text=self.descriptionData
                             
                          }
            
                    })

      
   

      
    
       
    }
    


}
