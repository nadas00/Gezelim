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
    var databaseHandle:DatabaseHandle?
    var postData = [String]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
    
        
      
       
   
            
        //cell ismi belirler
        cell.labelCell.text=postData[indexPath.row]
           
     

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        guard let cell = cell as? VCTableViewCell else { return }
        
        cell.animate()
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        gezilecekYerlerSearchBar.endEditing(true)
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
        
        
        //konak , alsc vb. ait değerler
        
        seciliGezilecekYer = indexPath.item+1
        
        if seciliSehir=="izmir"{
    
       seciliAciklama = aciklamalar[indexPath.row]
       seciliResim = fotolar[indexPath.row]}
        if seciliSehir=="istanbul"{
      
            seciliAciklama = aciklamalar[(indexPath.row+3)]
            seciliResim = fotolar[(indexPath.row+3)]
            
        }
            
        
        
        
             performSegue(withIdentifier: "tanitimBaglantisi", sender: nil)
        }
      
        
        
  
    
   

    @IBOutlet weak var gezilecekYerlerTableView: UITableView!
    @IBOutlet weak var gezilecekYerlerSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
         self.gezilecekYerlerTableView.separatorColor = UIColor.clear
        super.viewDidLoad()
         addNavBarImage()
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
         ref = Database.database().reference()
         //retrieve post and listen for changes
        ref?.child("cities").child(String(secilmisSehir)).child("tripLocations").observe(.childAdded, with: { (snapshot) in
            
           
             //code to execute when a child added under Posts
            let post = snapshot.childSnapshot(forPath: "locationName").value as? String
             if let actualPost = post{
                 self.postData.append(actualPost)
                print(actualPost)
                self.gezilecekYerlerTableView.reloadData()
             }
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
        searchGezilecekYerler = SegGezilecekYerler.filter({$0.prefix(searchText.count)==searchText})
        searching=true
        gezilecekYerlerTableView.reloadData()
       
    }
}
