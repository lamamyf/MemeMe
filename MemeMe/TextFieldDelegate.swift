//
//  TextFieldDelegate.swift
//  te
//
//  Created by Lama AlMayouf on 6/3/20.
//  Copyright © 2020 Lama AlMayouf. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate : NSObject , UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
