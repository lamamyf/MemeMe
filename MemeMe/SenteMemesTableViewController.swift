//
//  SenteMemesTableViewController.swift
//  Meme1.0
//
//  Created by Lama AlMayouf on 6/13/20.
//  Copyright © 2020 Lama AlMayouf. All rights reserved.
//

import UIKit

class SenteMemesTableViewController: UITableViewController {
    
    var memes : [Meme]!{
            let object =  UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return memes.count
     }
     
      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath)
         let meme = memes[indexPath.row]
       
         cell.imageView?.image = meme.memedImage
         cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        
         return cell
     }
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let meme = memes[indexPath.row]
         
         let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.memedImage = meme.memedImage
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(detailVC, animated: true)
     }
     

}
