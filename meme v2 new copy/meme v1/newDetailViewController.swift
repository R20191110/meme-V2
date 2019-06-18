//
//  newDetailViewController.swift
//  meme v1
//
//  Created by mac pro on 02/09/1440 AH.
//  Copyright © 1440 mac pro. All rights reserved.
//

import UIKit

class newDetailViewController: UIViewController {

    var memes: [Meme]!

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var image: UIImage?
   // var topText: String?
   // var bottomText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
