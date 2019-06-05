//
//  GezilecekYerlerViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 3.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class GezilecekYerlerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    

    var seciliGezilecekYer = ""
    var seciliResim = UIImage()
    var seciliAciklama = ""
    var seciliSehir=""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let tanitimVC = segue.destination as! tanitimViewController
        
        tanitimVC.baslik1 = seciliGezilecekYer
        tanitimVC.resim1 = seciliResim
        tanitimVC.aciklama1 = seciliAciklama
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //konak , alsc vb. ait değerler
        
        seciliGezilecekYer = SegGezilecekYerler[indexPath.row]
        
        if seciliSehir=="izmir"{
    
       seciliAciklama = aciklamalar[indexPath.row]
       seciliResim = fotolar[indexPath.row]}
        if seciliSehir=="istanbul"{
      
            seciliAciklama = aciklamalar[(indexPath.row+3)]
            seciliResim = fotolar[(indexPath.row+3)]
            
        }
            
        
        
        
             performSegue(withIdentifier: "tanitimBaglantisi", sender: nil)
        }
      
        
        
    
   
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SegGezilecekYerler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=SegGezilecekYerler[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var gezilecekYerlerTableView: UITableView!
    
    
    override func viewDidLoad() {
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
