//
//  ViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 3.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
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
    
       var sehirler = [String]()
    var izmirGezilecekYerler = [String]()
    var istanbulGezilecekYerler = [String]()
    var AnkaraGezilecekYerler = [String]()
    var gezilecekYerler = [String]()
    var ilkSayfaSecilenSehir = ""
    var searchSehir = [String]()
    var searching = false
    var sehirLogoları = [UIImage]()
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchSehir.count
        }else{
             return sehirler.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! VCTableViewCell
        if searching{
            cell.labelCell.text = searchSehir[indexPath.row]
            
           
            }
        
        else{
            cell.labelCell.text=sehirler[indexPath.row]
           
        }
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gezilecekBağlantısı" {
            
            
            let destinationVC = segue.destination as! GezilecekYerlerViewController
            
            destinationVC.SegGezilecekYerler=gezilecekYerler
            destinationVC.seciliSehir=ilkSayfaSecilenSehir
            
        }
        
        
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            ilkSayfaSecilenSehir="izmir"
            gezilecekYerler = izmirGezilecekYerler
            
        }
        if indexPath.item == 1 {
            ilkSayfaSecilenSehir="istanbul"
            gezilecekYerler = istanbulGezilecekYerler
            
        }
       
        performSegue(withIdentifier: "gezilecekBağlantısı", sender: nil)
    }
    
    
    override func viewDidLoad() {
        
        sehirLogoları.append(UIImage(named: "izmir-buyuksehir-belediyesi-vector-logo-small")!)
        sehirLogoları.append(UIImage(named: "ist.jpg")!)
        sehirLogoları.append(UIImage(named: "ank.jpg")!)
        
        super.viewDidLoad()
         addNavBarImage()
        
        tableView.dataSource=self
        tableView.delegate=self
        
       
        
        izmirGezilecekYerler.append("konak")
        izmirGezilecekYerler.append("alsancak")
        izmirGezilecekYerler.append("kemeraltı")
        
        istanbulGezilecekYerler.append("Ayasofya Müzesi")
        istanbulGezilecekYerler.append("Sultan Ahmet Camii")
        istanbulGezilecekYerler.append("Topkapi")
        
        do {
            // This solution assumes  you've got the file in your bundle
            if let path = Bundle.main.path(forResource: "sehirler", ofType: "txt"){
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                sehirler = data.components(separatedBy: ", ")
                
            }
        } catch let err as NSError {
            // do something with Error
            print(err)
        }
        
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


