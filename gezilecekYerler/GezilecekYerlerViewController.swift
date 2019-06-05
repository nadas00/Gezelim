//
//  GezilecekYerlerViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 3.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class GezilecekYerlerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
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

        gezilecekYerlerTableView.dataSource=self
        gezilecekYerlerTableView.delegate=self
        
        aciklamalar.append("konak güzeldir")
        aciklamalar.append("alsancak güzeldir")
        aciklamalar.append("kemeralti güzeldir")
        aciklamalar.append("ayasofya güzeldir")
        aciklamalar.append("sultanahmet güzeldir")
        aciklamalar.append("topkapı güzeldir")
        
        
        fotolar.append(UIImage(named: "konak.jpg")!)
        fotolar.append(UIImage(named: "alsancak.jpg")!)
         fotolar.append(UIImage(named: "kemeralti.jpg")!)

        
        
        fotolar.append(UIImage(named: "ayasofya.jpg")!)
        fotolar.append(UIImage(named: "sultanahmet.jpg")!)
        fotolar.append(UIImage(named: "topkapi.jpg")!)
        
        
        
    }
    



}
