//
//  ViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 3.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
       var sehirler = [String]()
    var izmirGezilecekYerler = [String]()
    var istanbulGezilecekYerler = [String]()
    var AnkaraGezilecekYerler = [String]()
    var gezilecekYerler = [String]()
    var ilkSayfaSecilenSehir = ""
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sehirler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=sehirler[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
        super.viewDidLoad()
        
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
                sehirler = data.components(separatedBy: "--")
                
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

