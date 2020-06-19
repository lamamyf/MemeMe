//
//  ViewController.swift
//  te
//
//  Created by Lama AlMayouf on 6/3/20.
//  Copyright © 2020 Lama AlMayouf. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate ,  UINavigationControllerDelegate{


        let textFieldDelegate = TextFieldDelegate()
    
        let imagePicker = UIImagePickerController()
        
       
        @IBOutlet weak var toolBar: UIToolbar!
        @IBOutlet weak var imagePickerView: UIImageView!
        @IBOutlet weak var cameraBtn: UIBarButtonItem!
        @IBOutlet weak var shareBtn: UIBarButtonItem!
        @IBOutlet weak var topTextField: UITextField!
        @IBOutlet weak var bottomTextField: UITextField!
        
      
        
    override func viewDidLoad() {
            super.viewDidLoad()
            imagePickerView.contentMode = .scaleAspectFit
            setUpTextFields(topTextField, "TOP")
            setUpTextFields(bottomTextField, "BOTTOM")
        }
        
    func setUpTextFields(_ textField : UITextField,_ title:String){
            textField.delegate = textFieldDelegate
            
            let memeTextAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.strokeColor: UIColor.black,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSAttributedString.Key.strokeWidth:  -3.6]
            
            textField.defaultTextAttributes = memeTextAttributes
            textField.textAlignment = NSTextAlignment.center
            textField.text = title
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            shareBtn.isEnabled = false
            subscribeToKeyboardWillShowNotifications()
            subscribeToKeyboardWillHideNotifications()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            unsubscribeFromKeyboardWillShowNotifications()
            unsubscribeFromKeyboardWillHideNotifications()
        }
    
        func setUPImagePicker(_ sourceType: UIImagePickerController.SourceType){
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            present(imagePicker, animated: true, completion: nil)
        }
        @IBAction func pickAnImageFromCamera(_ sender: Any) {
            setUPImagePicker(.camera)
        }
        
        @IBAction func pickAnImageFromAlbum(_ sender: Any) {
            setUPImagePicker(.photoLibrary)
        }
        
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                imagePickerView.contentMode = .scaleAspectFit
                imagePickerView.image = image
            }
            
            shareBtn.isEnabled = true
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
             dismiss(animated: true, completion: nil)
        }
     
        @IBAction func cancel(_ sender: Any) {
          dismiss(animated: true, completion: nil)
        }
    
        @IBAction func share(_ sender: Any) {
            let memedImage = generateMemedImage()
            let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
            activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if completed{
                    self.save()
                   self.PresentSentMemesViewController()
                }
            }
            
            activityController.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
            self.present(activityController, animated: true, completion: nil)
        }
    
        func PresentSentMemesViewController(){
            if var topController = UIApplication.shared.keyWindow?.rootViewController{
            while let presentedViewController = topController.presentedViewController{
                topController = presentedViewController
            }
           let TabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
           
           TabBarController!.modalPresentationStyle = .fullScreen
           topController.present(TabBarController! , animated: true, completion: nil)
        }
    }
    
        func save(){
            let meme = Meme(topText: topTextField.text! , bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
            
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        }
        
        func navBarToolBarHide(_ hide : Bool){
            navigationController?.navigationBar.isHidden = hide
            toolBar.isHidden = hide
        }
    
        func generateMemedImage()-> UIImage{
            navBarToolBarHide(true)
            
            UIGraphicsBeginImageContext(view.frame.size)
            view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
            let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            navBarToolBarHide(false)
            return memedImage
        }
    
        func subscribeToKeyboardWillShowNotifications(){
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        
        func subscribeToKeyboardWillHideNotifications(){
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
           }
        
        @objc func keyboardWillShow(_ notification:Notification){
            if bottomTextField.isEditing{
                view.frame.origin.y -= getKeyboardHeight(notification)
            }
        }
        
        @objc func keyboardWillHide(_ notification:Notification){
            if bottomTextField.isEditing{
                 view.frame.origin.y = 0
            }
        }
        
        func getKeyboardHeight (_ notification:Notification) -> CGFloat{
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            
            return keyboardSize.cgRectValue.height
        }
        
        func unsubscribeFromKeyboardWillShowNotifications(){
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        
        func unsubscribeFromKeyboardWillHideNotifications(){
               NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
           }
    }

