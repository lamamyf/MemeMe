//
//  DetailViewController.swift
//  Meme1.0
//
//  Created by Lama AlMayouf on 6/14/20.
//  Copyright © 2020 Lama AlMayouf. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var memedImageView: UIImageView!
    var memedImage: UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memedImageView.image = memedImage
        memedImageView.contentMode = .scaleAspectFit
    }

}

