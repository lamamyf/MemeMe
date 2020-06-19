//
//  NavigationController.swift
//  Meme1.0
//
//  Created by user174050 on 6/13/20.
//  Copyright © 2020 lama. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sent Memes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMemeEditor))
        // Do any additionl setup after loading the view.
    }
    
    @objc func showMemeEditor(){
        let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController")
        /*navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(memeVC! , animated: true)*/
        memeVC?.modalPresentationStyle = .fullScreen
        present(memeVC! , animated: true, completion: nil)
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
