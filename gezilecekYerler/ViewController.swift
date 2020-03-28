//
//  ViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 3.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    
 
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)

    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        
        guard let cell = cell as? VCTableViewCell else { return }
        
        cell.animate()
        
    }
    //soldan sağa okunan diller için sağda bulunan kaydırma konfigrasyonu //tr :Sol
    /*
     func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorites = UIContextualAction(style: .normal, title: "Favorilere Ekle") { (action, view, nil) in
            print("favorilere eklendi")
           
        }
        return UISwipeActionsConfiguration(actions: [favorites])
    }
 */
    //soldan sağa okunan diller için solda bulunan kaydırma konfigrasyonu //tr :Sağ

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
    
    

    var ref: DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var postData = [String]()

    
    //job1: sehir isimlerini firebaseten çekip tableview'a gönder.
    //sehir isimleri
    var sehirler = [String]()
    
    
    
    
    
    
    var izmirGezilecekYerler = [String]()
    var istanbulGezilecekYerler = [String]()
    var AnkaraGezilecekYerler = [String]()
    var gezilecekYerler = [String]()
    var ilkSayfaSecilenSehir = 0
    var searchSehir = [String]()
    var searching = false
    var sehirLogoları = [UIImage]()
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchSehir.count
        }else{
            return postData.count
        }
       
    }
    

    
    //table oluşturur
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
    
        
      
        
        if searching{
            cell.labelCell.text = searchSehir[indexPath.row]
            
           
            }
        
        else{
            
        //cell ismi belirler
           cell.labelCell.text=postData[indexPath.row]
           
        }
        

        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gezilecekBağlantısı" {
            
            
            let destinationVC = segue.destination as! GezilecekYerlerViewController
            
            // işe yaramaz destinationVC.SegGezilecekYerler=gezilecekYerler
            destinationVC.secilmisSehir = ilkSayfaSecilenSehir
            
        }
        
        
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
            ilkSayfaSecilenSehir = indexPath.item+1
           
            
  
       
        performSegue(withIdentifier: "gezilecekBağlantısı", sender: nil)
    }
    
    
    override func viewDidLoad() {
        
        
        
        //satır aralığı çizgilerini siler
   self.tableView.separatorColor = UIColor.clear
        
        sehirLogoları.append(UIImage(named: "izmir-buyuksehir-belediyesi-vector-logo-small")!)
        sehirLogoları.append(UIImage(named: "ist.jpg")!)
        sehirLogoları.append(UIImage(named: "ank.jpg")!)
        
        super.viewDidLoad()
         addNavBarImage()
        
        tableView.dataSource=self
        tableView.delegate=self
        
        //set firebase reference
        ref = Database.database().reference()
        //retrieve post and listen for changes
        ref?.child("cities").observe(.childAdded, with: { (snapshot) in
            
            
            //code to execute when a child added under Posts
            let post = snapshot.childSnapshot(forPath: "provinceName").value as? String
            if let actualPost = post{
                self.postData.append(actualPost)
                self.tableView.reloadData()
            }
        })
        
        
        
       
        
        izmirGezilecekYerler.append("konak")
        izmirGezilecekYerler.append("alsancak")
        izmirGezilecekYerler.append("kemeraltı")
        
        istanbulGezilecekYerler.append("Ayasofya Müzesi")
        istanbulGezilecekYerler.append("Sultan Ahmet Camii")
        istanbulGezilecekYerler.append("Topkapi")
    
        
        //sehirleri doldurma işini siliyorum
        
//        do {
//            // This solution assumes  you've got the file in your bundle
//            if let path = Bundle.main.path(forResource: "sehirler", ofType: "txt"){
//                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
//                sehirler = data.components(separatedBy: ", ")
//
//            }
//        } catch let err as NSError {
//            // do something with Error
//            print(err)
//        }
        
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: "izmirGezilecekYerler", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                izmirGezilecekYerler = data.components(separatedBy: "--")
                
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        
        // Do any additional setup after loading the view.
    }



    
}


extension ViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSehir = sehirler.filter({$0.prefix(searchText.count)==searchText})
        searching=true
        tableView.reloadData()
    }
}


