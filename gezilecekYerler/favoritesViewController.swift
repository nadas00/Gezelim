//
//  favoritesViewController.swift
//  gezilecekYerler
//
//  Created by hasan çiftçi on 27.03.2020.
//  Copyright © 2020 trihay. All rights reserved.
//

import UIKit
import FirebaseDatabase

class favoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var postData = [String]()
    var favSecilenSehir = 0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
         cell.labelCell.text=postData[indexPath.row]
            return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        guard let cell = cell as? VCTableViewCell else { return }
        
        cell.animate()
        
    }
    
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
         
              favSecilenSehir = indexPath.item+1
             
              
    
         
          performSegue(withIdentifier: "fav", sender: nil)
      }
    

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "fav" {
               
               
               let destinationVC = segue.destination as! favoriteLocationsViewController
               
               // işe yaramaz destinationVC.SegGezilecekYerler=gezilecekYerler
            destinationVC.secilmisFavLoc = favSecilenSehir
               
           }
           
           
       }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
              let deneme = UIContextualAction(style: .destructive, title: "Kaldır") { (action, view, nil) in
                  
                  
                   let swipedLocation = indexPath.item+1
                
                
                
      //             print(swipedLocation)
      //             print(self.secilmisSehir)
                  
                  self.ref = Database.database().reference()
                 
                         //retrieve post and listen for changes
                 
                self.ref?.observeSingleEvent(of: .childRemoved, with: { (snapshot) in
                
                     
                    self.ref.child("favorites").child(String(swipedLocation)).removeValue()
                  
                        
                       self.favoritesTable.reloadData()
                    
               })
                
                
                           self.ref?.observeSingleEvent(of: .value, with: { (snapshot) in
                           
                           let post = snapshot.childSnapshot(forPath: "favorites").childSnapshot(forPath: String(swipedLocation)).childSnapshot(forPath: "provinceName").value as? String
                            if let actualPost = post{
                                
                            
                               
                                    self.ref.child("favorites").child(String(swipedLocation)).setValue(["provinceName": actualPost])
                                   
                                  self.favoritesTable.reloadData()
                               }
                          })
                
                      }
             

       
               return UISwipeActionsConfiguration(actions: [deneme])
        
          }
          

    
    @IBOutlet weak var favoritesTable: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.favoritesTable.separatorColor = UIColor.clear
         favoritesTable.dataSource=self
         favoritesTable.delegate=self
        
        //set firebase reference
        ref = Database.database().reference().child("favorites")
              //retrieve post and listen for changes
        ref?.observe(.childAdded, with: { (snapshot) in
                  
         
                  //code to execute when a child added under Posts
                      let post = snapshot.childSnapshot(forPath: "provinceName").value as? String
                       if let actualPost = post{
                           self.postData.append(actualPost)
                          print(actualPost)
                          
                       }
                     self.favoritesTable.reloadData()
              })
        
       
              
              
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
