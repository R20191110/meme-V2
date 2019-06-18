//
//  collectionViewController.swift
//  meme v1
//
//  Created by mac pro on 18/08/1440 AH.
//  Copyright © 1440 mac pro. All rights reserved.
//

import UIKit

class collectionViewController: UIViewController {

    var memes: [Meme]!
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! CollectionViewCell
        cell.imageCell.image = memes[indexPath.row].memedObject
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        let detailController = UIStoryboard(name: "DetailsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "DetailsCollectionViewCell") as! ViewController
        present(detailController, animated: true, completion: nil)
        detailController.imageView.image = meme.memedObject
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //TODO: Set the left and right spacing of a cell to be 2
        return UIEdgeInsets(top: 200, left: spacing, bottom: 0, right: spacing)
        
    }
    
    let spacing: CGFloat = 5
    let numberOfItemsInRow: CGFloat = 3
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //TODO: Set the columns to 2 and the rows to 2 in a rectangle area of the collection view (ususally the area visible on the secreen).
        let width = collectionView.frame.width
        let widthWithoutMargins = width - ((numberOfItemsInRow + 1) * spacing)
        let itemWidth = widthWithoutMargins / numberOfItemsInRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //TODO: Set minimumLineSpacing to 0
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //TODO: Set minimumInteritemSpacing to 0
        return spacing
    }
    

}
