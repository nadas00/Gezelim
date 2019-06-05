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
    var seciliGezilecekYer = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let tanitimVC = segue.destination as! tanitimViewController
        
        tanitimVC.baslik1 = seciliGezilecekYer
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        seciliGezilecekYer = SegGezilecekYerler[indexPath.row]
    
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
        
        
    }
    



}
