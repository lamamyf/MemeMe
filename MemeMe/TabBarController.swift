//
//  TabBarController.swift
//  Meme1.0
//
//  Created by user174050 on 6/13/20.
//  Copyright © 2020 lama. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // l//et vc = self.viewControllers![0] as! UINavigationController).navigationBar.topItem?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeEditor))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeEditor))

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.visibleViewController?.title = "sent memes"
        navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeEditor))
    }
  
    @objc func showMemeEditor(){
        let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController")
         
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(memeVC! , animated: true)
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
