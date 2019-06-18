//
//  detailViewController.swift
//  meme v1
//
//  Created by mac pro on 01/09/1440 AH.
//  Copyright © 1440 mac pro. All rights reserved.
//

import UIKit


class detailViewController: UIViewController {

     var memes: [Meme]!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bottom: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

}
