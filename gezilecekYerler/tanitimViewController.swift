//
//  tanitimViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 4.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//
import UIKit
import FirebaseDatabase
import FirebaseStorage

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
    
    
  
    var longsOfLocation = 0.0
    var latsOfLocation = 0.0
    
    
    @IBOutlet weak var baslik: UILabel!
    @IBOutlet weak var aciklama: UITextView!
    @IBOutlet weak var slideImages: UIImageView!
    @IBAction func shareLocation(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: ["Bu mekana göz atmanı istiyorum!"," ",baslik.text!," ",descriptionData,"Gezelim(iOS) uygulaması Kullanılarak Gönderildi"], applicationActivities: nil)
        present(activityController,animated: true,completion: nil)
        
    }
    @IBAction func showOnMap(_ sender: Any) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap" {
                          
                          
 let destinationVC = segue.destination as! mapViewController
            destinationVC.locationNames = [topicData]
            destinationVC.longs = [longsOfLocation]
            destinationVC.lats = [latsOfLocation]
        
    }
    }
    
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    let storage = Storage.storage()
    

    var topicData = ""
    var descriptionData = ""
    var secilmisGezilecekYer = 0
    var secilmisSehir = 0
    var imgData = [String]()
    var imgArr = [UIImage]()
    var selectedPhoto = 0

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
                 
                            self.baslik.text=self.topicData
                           
                        }
            
            //code to execute when a child added under Posts
              let description = snapshot.childSnapshot(forPath: "description").value as? String
                          if let actualPost2 = description{
                              self.descriptionData=actualPost2
                   
                              self.aciklama.text=self.descriptionData
                             
                          }
            
            //long reciever
            self.longsOfLocation = snapshot.childSnapshot(forPath: "long").value as! Double
            
            //lat reciever
            self.latsOfLocation = snapshot.childSnapshot(forPath: "lat").value as! Double
            
                    })
        
        
       
        ref?.child("cities").child(String(secilmisSehir)).child("tripLocations").child(String(secilmisGezilecekYer)).child("tripLocationImg").observe(.value, with: { (snapshot) in
            
            let imageCount = snapshot.childrenCount
           
            if imageCount > 0
            {
                for indexx in 1...imageCount
                {
                           let images = snapshot.childSnapshot(forPath: String(indexx)).value as? String
                                                           if let actualPost3 = images
                                                           {
                                                               self.imgData.append(actualPost3)
                                                               print(actualPost3)
                                                            let storageRef = self.storage.reference().child(self.imgData[0]+".jpg")
                                                            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                                                      if let error = error {
                                                                          print("PLASESEE")
                                                                          print(error.localizedDescription)
                                                                          // Uh-oh, an error occurred!
                                                                      } else {
                                                                          // Data for "images/island.jpg" is returned
                                                                         self.slideImages.image =  UIImage(data: data!)
                                                                      }
                                                                  }
                                                                  
                                                              
                                                            }
                }
                
                
                
         
                
            }
 })


        
        
        let bitirdim = UITapGestureRecognizer(target: self, action: #selector(heisenSakla))
               slideImages.addGestureRecognizer(bitirdim)
               slideImages.isUserInteractionEnabled = true

              
               
           }
           
           
           @objc func heisenSakla(){
                  
                     
                      ref?.child("cities").child(String(secilmisSehir)).child("tripLocations").child(String(secilmisGezilecekYer)).child("tripLocationImg").observe(.value, with: { (snapshot) in
                          
                          let imageCount = snapshot.childrenCount
                         
                          if imageCount > 0
                          {
                              for indexx in 1...imageCount
                              {
                                         let images = snapshot.childSnapshot(forPath: String(indexx)).value as? String
                                                                         if let actualPost3 = images
                                                                         {
                                                                             self.imgData.append(actualPost3)
                                                                        
                                                                          }
                              }
                              
                              
                              
                       
                              
                          }
                          if self.selectedPhoto == imageCount{
                              self.selectedPhoto = 0
                          }
                          let storageRef = self.storage.reference().child(self.imgData[self.selectedPhoto]+".jpg")
                          storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        print("PLASESEE")
                                        print(error.localizedDescription)
                                        // Uh-oh, an error occurred!
                                    } else {
                                        // Data for "images/island.jpg" is returned
                                       self.slideImages.image =  UIImage(data: data!)
                                    }
                                }

               })
               self.selectedPhoto =  self.selectedPhoto+1
               print(selectedPhoto)
                }
        
        
        
        
    }
    



