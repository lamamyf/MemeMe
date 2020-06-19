//
//  SentMemesCollectionCollectionViewController.swift
//  Meme1.0
//
//  Created by user174050 on 6/16/20.
//  Copyright © 2020 lama. All rights reserved.
//

import UIKit

class SentMemesCollectionCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
  var memes : [Meme]!{
              let object =  UIApplication.shared.delegate
              let appDelegate = object as! AppDelegate
              return appDelegate.memes
      }
      
    
      //let dim  = (collectionView.frame.size.width - (numberOfItemsPerRow - 1) * lineSpacing)
      

  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
      let space: CGFloat = 2.0
               let numberOfItemsPerRow : CGFloat = 3.0
               let lineSpacing : CGFloat = 5.0
     
    @IBOutlet var collectionView: UICollectionView!
    
      override func viewDidLoad() {
          super.viewDidLoad()
        setUpFlowLayout()

      }
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          tabBarController?.tabBar.isHidden = false
       // view.reloadData()
      }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.setUpFlowLayout()
        }, completion: nil)
        super.viewWillTransition(to: size, with: coordinator)
        
    }

      
      func setUpFlowLayout(){
          let space: CGFloat = 2.0
          let numberOfItemsPerRow : CGFloat = 3.0
          let lineSpacing : CGFloat = 5.0
        print("xxx")
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
          flowLayout.sectionInset = UIEdgeInsets.zero
          
           let dim  = ( view.frame.size.width - (numberOfItemsPerRow - 1 ) * lineSpacing)  / numberOfItemsPerRow
           let z  = ( view.frame.size.height - (numberOfItemsPerRow - 1 ) * lineSpacing)  / numberOfItemsPerRow
       
          flowLayout.itemSize =  CGSize(width: 200 , height: 200)
          
      }
   
      // MARK: UICollectionViewDataSource


       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of items
          return memes.count
      }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemedImageCell", for: indexPath) as! MemeCollectionViewCell
          
          let meme = memes[indexPath.item]
          cell.memedImageView.image = meme.memedImage
          
          return cell
      }

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let meme = memes[indexPath.item]
          let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
          detailVC.memedImage = meme.memedImage
          tabBarController?.tabBar.isHidden = true
          navigationController?.pushViewController(detailVC, animated: true)
      }

      

  }

extension SentMemesCollectionCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        var x = collectionView.frame.size.width
    
        let dim  = ( x - (numberOfItemsPerRow - 1.0 ) * lineSpacing)  / numberOfItemsPerRow
        let z  = ( collectionView.frame.size.height - (numberOfItemsPerRow - 1.0 ) * lineSpacing)  / numberOfItemsPerRow
        return CGSize(width: dim , height: z)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

