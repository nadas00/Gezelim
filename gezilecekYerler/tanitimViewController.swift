//
//  tanitimViewController.swift
//  gezilecekYerler
//
//  Created by gofret on 4.06.2019.
//  Copyright © 2019 trihay. All rights reserved.
//

import UIKit

class tanitimViewController: UIViewController {
    
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var baslik: UILabel!
    @IBOutlet weak var aciklama: UITextView!
    
    
    var GezilecekYerBasliklari = [String]()
    var resim1 = UIImage()
    var baslik1=""
    var aciklama1=""

    override func viewDidLoad() {
        super.viewDidLoad()

       resim.image=resim1
        baslik.text=baslik1
        aciklama.text=aciklama1
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
