//
//  GezilecekYerlerViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 3.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit
import FirebaseDatabase


class GezilecekYerlerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var ref: DatabaseReference!
    var swipeRef:DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var postData = [String]()
    var favLat = 0.0
    var favLong = 0.0
    var favLoc = ""
    var favLocId = ""
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchGezilecekYerler.count
        }else{
            return postData.count
        }
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
    
        
      
       
         
     if searching{
         cell.labelCell.text = searchGezilecekYerler[indexPath.row]
         
        
         }
     
     else{
         
     //cell ismi belirler
        cell.labelCell.text=postData[indexPath.row]
        
     }
           
     

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        guard let cell = cell as? VCTableViewCell else { return }
        
        cell.animate()
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        gezilecekYerlerSearchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deneme = UIContextualAction(style: .normal, title: "DENEME") { (action, view, nil) in
            
var swipedLocation = 0
            var postDataIndex=1
            if self.searching{

                
                for index in self.postData{
                    if(index == self.searchGezilecekYerler[indexPath.item].description){
                        swipedLocation = postDataIndex
                 
                       
                        
                    }
                    postDataIndex+=1
                }
                
                


            }else{
                 swipedLocation = indexPath.item+1
                

               

            }
            
     
//             print(swipedLocation)
//             print(self.secilmisSehir)
            
            self.ref = Database.database().reference()
            self.swipeRef=Database.database().reference()
                   //retrieve post and listen for changes
            self.ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            //code to execute when a child added under Posts
                let post = snapshot.childSnapshot(forPath: "cities").childSnapshot(forPath: String(self.secilmisSehir)).childSnapshot(forPath: "tripLocations").childSnapshot(forPath: String(swipedLocation)).childSnapshot(forPath: "locationName").value as? String
                       if let actualPost = post{
                           
                      
                        self.favLoc=actualPost
                          
                       }
                
                     let post2 = snapshot.childSnapshot(forPath: "cities").childSnapshot(forPath: String(self.secilmisSehir)).childSnapshot(forPath: "tripLocations").childSnapshot(forPath: String(swipedLocation)).childSnapshot(forPath: "lat").value as? Double
                                        if let actualPost2 = post2{
                                            self.favLat=actualPost2
                                           }
                
                
       let post3 = snapshot.childSnapshot(forPath: "cities").childSnapshot(forPath: String(self.secilmisSehir)).childSnapshot(forPath: "tripLocations").childSnapshot(forPath: String(swipedLocation)).childSnapshot(forPath: "long").value as? Double
                                         if let actualPost3 = post3{
                                             self.favLong=actualPost3
                                            }
             
           
                   
                                    
                self.ref.child("favorites").child(String(self.secilmisSehir)).queryOrdered(byChild: "locationName").queryEqual(toValue: post).observeSingleEvent(of: .value, with: { snapshot in

                                         if (snapshot.value is NSNull) {
                                             print("Name is not in use")

                                            self.ref.child("favorites").child(String(self.secilmisSehir)).childByAutoId().setValue(["locationName": post,"lat":post2, "long":post3])
                                         } else {
                                             print("Name is in use")
                                         }
                    
                    self.gezilecekYerlerTableView.reloadData()
                                     })
                    


             
                   
         
                })
            
          
        }
        
     
        deneme.image = #imageLiteral(resourceName: "swipeFav")
        deneme.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
         return UISwipeActionsConfiguration(actions: [deneme])
    }
    
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
    
    
    
    var SegGezilecekYerler = [String]()
    var fotolar = [UIImage]()
    var aciklamalar = [String]()
    var secilmisSehir = 0
    var seciliGezilecekYer = 0
    var seciliResim = UIImage()
    var seciliAciklama = ""
    var seciliSehir=""
    var searchGezilecekYerler = [String]()
    var searching = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let tanitimVC = segue.destination as! tanitimViewController

        tanitimVC.secilmisGezilecekYer = seciliGezilecekYer
        tanitimVC.secilmisSehir = secilmisSehir
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var postDataIndex = 1
        if searching{

                
                for index in self.postData{
                    if(index == searchGezilecekYerler[indexPath.item].description){
                       seciliGezilecekYer = postDataIndex
                         performSegue(withIdentifier: "tanitimBaglantisi", sender: nil)
                       
                        
                    }
                    postDataIndex+=1
                }
                
                


            }else{
                 seciliGezilecekYer = indexPath.item+1
                 performSegue(withIdentifier: "tanitimBaglantisi", sender: nil)

               

            }
 
        
        
       
        }
      
        
        
  
    
   

    @IBOutlet weak var gezilecekYerlerTableView: UITableView!
    @IBOutlet weak var gezilecekYerlerSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
         self.gezilecekYerlerTableView.separatorColor = UIColor.clear
        super.viewDidLoad()
         addNavBarImage()
        
        print(secilmisSehir)
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: "aciklamalar", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                aciklamalar = data.components(separatedBy: "--")
               
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        //set firebase reference
         ref = Database.database().reference().child("cities")
         //retrieve post and listen for changes
        ref?.child(String(secilmisSehir)).child("tripLocations").observe(.childAdded, with: { (snapshot) in
            
           
             //code to execute when a child added under Posts
            let post = snapshot.childSnapshot(forPath: "locationName").value as? String
             if let actualPost = post{
                 self.postData.append(actualPost)
               
               
             }
            self.gezilecekYerlerTableView.reloadData()
         })
         

        gezilecekYerlerTableView.dataSource=self
        gezilecekYerlerTableView.delegate=self
        
        
     
        
        
        fotolar.append(UIImage(named: "konak.jpg")!)
        fotolar.append(UIImage(named: "alsancak.jpg")!)
         fotolar.append(UIImage(named: "kemeralti.jpg")!)

        
        
        fotolar.append(UIImage(named: "ayasofya.jpg")!)
        fotolar.append(UIImage(named: "sultanahmet.jpg")!)
        fotolar.append(UIImage(named: "topkapi.jpg")!)
        
        
        
    }
    



}

extension GezilecekYerlerViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGezilecekYerler = postData.filter({$0.prefix(searchText.count)==searchText})
        searching=true
        gezilecekYerlerTableView.reloadData()
       
    }
}
