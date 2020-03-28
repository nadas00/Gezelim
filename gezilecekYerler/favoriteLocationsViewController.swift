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
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.favLocationsTable.separatorColor = UIColor.clear
        //set firebase reference
           ref = Database.database().reference()
           //retrieve post and listen for changes
          ref?.child("favorites").child(String(secilmisFavLoc)).observe(.childAdded, with: { (snapshot) in
              
             
               //code to execute when a child added under Posts
              let post = snapshot.childSnapshot(forPath: "locationName").value as? String
               if let actualPost = post{
                   self.postData.append(actualPost)
                  print(actualPost)
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
