//
//  tableViewController.swift
//  meme v1
//
//  Created by mac pro on 18/08/1440 AH.
//  Copyright © 1440 mac pro. All rights reserved.
//


import UIKit

class tableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memes: [Meme]!{
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellContent", for: indexPath) as! tableCell
    
        let editedImage = memes[indexPath.row]
        cell.tobCell.text = editedImage.topText
        cell.bottomCell.text = editedImage.bottomText
        cell.imageCell.image = editedImage.memedObject
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newDetailViewController") as! newDetailViewController
      
        detailController.image = meme.memedObject
       

        self.navigationController?.pushViewController(detailController, animated: true)
        
    }
}


