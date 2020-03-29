//
//  favoriteLocationsViewController.swift
//  gezilecekYerler
//
//  Created by hasan çiftçi on 27.03.2020.
//  Copyright © 2020 trihay. All rights reserved.
//

import UIKit
import FirebaseDatabase

class favoriteLocationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var favLocationsTable: UITableView!
    
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var postData = [String]()
    var secilmisFavLoc = 0
    var selectChild = [String]()
    
    

     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return postData.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         let cell = favLocationsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
     
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          
           
           guard let cell = cell as? VCTableViewCell else { return }
           
           cell.animate()
           
       }
         
       
        
    
             
         //cell ismi belirler
         cell.labelCell.text=postData[indexPath.row]
            
      

         return cell
     }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        guard let cell = cell as? VCTableViewCell else { return }
        
        cell.animate()
        
    }
    
  
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              let deneme = UIContextualAction(style: .normal, title: "DENEME") { (action, view, nil) in
                  
 let swipedLocation = indexPath.item
                print(self.selectChild[swipedLocation])
                
                
                self.ref?.child("favoriler").child(String(self.secilmisFavLoc)).observeSingleEvent(of:.value, with: { (snapshot) in
                   
                    
                    self.ref.child("favorites").child(String(self.secilmisFavLoc)).child(self.selectChild[swipedLocation]).removeValue()
                                   
                                   self.selectChild.remove(at: swipedLocation)
                    self.postData.remove(at: swipedLocation)
                                   self.favLocationsTable.reloadData()
                    
                     })
                
               
                
                
              }
              

              deneme.image = #imageLiteral(resourceName: "swipeFav")
              deneme.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
               return UISwipeActionsConfiguration(actions: [deneme])
          }
          
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.favLocationsTable.separatorColor = UIColor.clear
        //set firebase reference
           ref = Database.database().reference()
           //retrieve post and listen for changes
        
        
        
        self.ref?.child("favorites").child(String(self.secilmisFavLoc)).observe(.childAdded, with: { (snapshot) in
                         
                                  let childatValue = snapshot.key as? String
                                   if let actualchildatValue = childatValue{
                                       self.selectChild.append(actualchildatValue)
                                     
                                      
                                      
                                   }
                               })
        
          ref?.child("favorites").child(String(secilmisFavLoc)).observe(.childAdded, with: { (snapshot) in
              
             
               //code to execute when a child added under Posts
              let post = snapshot.childSnapshot(forPath: "locationName").value as? String
               if let actualPost = post{
                   self.postData.append(actualPost)
                  print(actualPost)
                  self.favLocationsTable.reloadData()
               }
            
            let coord = snapshot.childSnapshot(forPath: "locationCoordination").value as? String
                          if let actualPost2 = coord{
                              
                             print(actualPost2)
                             self.favLocationsTable.reloadData()
                          }
           })
           

          favLocationsTable.dataSource=self
          favLocationsTable.delegate=self
          
        
        
        
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
