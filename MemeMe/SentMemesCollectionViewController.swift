//
//  SentMemesCollectionViewController.swift
//  Meme1.0
//
//  Created by Lama AlMayouf on 6/18/20.
//  Copyright © 2020 Lama AlMayouf. All rights reserved.
//

import UIKit


class SentMemesCollectionViewController: UICollectionViewController {

    var memes : [Meme]!{
        let object =  UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
            }
        let space : CGFloat = 3.0
       
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tabBarController?.tabBar.isHidden = false
            collectionView.reloadData()
        }
        
  
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
             coordinator.animate(alongsideTransition: { _ in
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.reloadData()
             }, completion: {_ in})
             super.viewWillTransition(to: size, with: coordinator)
             
         }

     
        // MARK: UICollectionViewDataSource


        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return memes.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemedImageCell", for: indexPath) as! MemeCollectionViewCell
                   
            let meme = memes[indexPath.item]
            cell.memedImageView.image = meme.originalImage
            
            let memeTextAttributes: [NSAttributedString.Key: Any] = [
                          NSAttributedString.Key.strokeColor: UIColor.black,
                          NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
                          NSAttributedString.Key.strokeWidth:  -3.6]
            
            cell.topTextFiled.attributedText = NSAttributedString(string: meme.topText, attributes: memeTextAttributes)
            cell.botttomTextFiled.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeTextAttributes)
            return cell
        }

        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             let meme = memes[indexPath.item]
             let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
             detailVC.memedImage = meme.memedImage
             tabBarController?.tabBar.isHidden = true
             navigationController?.pushViewController(detailVC, animated: true)
         }

    }

    extension SentMemesCollectionViewController: UICollectionViewDelegateFlowLayout{
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let dim = (view.frame.size.width - (2 * space)) / 3.0
            return CGSize(width: dim , height: dim)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return space
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return space
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
        }
    }
