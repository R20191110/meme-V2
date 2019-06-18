//
//  ViewController.swift
//  meme v1
//
//  Created by mac pro on 14/08/1440 AH.
//  Copyright © 1440 mac pro. All rights reserved.
//

import UIKit

struct Meme {
    var topText : String
    var bottomText : String
    var originalImage : UIImage
    var memedObject : UIImage
}

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var shareButtun: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoFromLibrary: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        self.tabBarController?.tabBar.isHidden = false

        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButtun.isEnabled = false
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topField.delegate = self
        bottomField.delegate = self
        
        setupTextField(tf: topField, text: "TOP")
        setupTextField(tf: bottomField, text: "BOTTOM")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[ UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            shareButtun.isEnabled = true
            
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -4.0
    ]
    func setupTextField(tf: UITextField, text: String) {
        tf.defaultTextAttributes = memeTextAttributes
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.placeholder = text
        tf.delegate = self
    }
    @IBAction func shareAction(_ sender: Any) {
        
        let img: UIImage = generateMemedImage()
        let shareItems:Array = [img]
        
        let activityController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityController.completionWithItemsHandler = { activity, completed, items, error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }}
        
        present(activityController, animated: true, completion: nil)

    }
    
    func chooseImageFromCameraOrPhoto(source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func addPhoto(_ sender: Any) {
        chooseImageFromCameraOrPhoto(source: .photoLibrary)
       
    }
    // camera function
    @IBAction func takePhoto(_ sender: Any) {
        chooseImageFromCameraOrPhoto(source: .camera)

    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
self.navigationController?.popViewController(animated: true)
    }
    
    func generateMemedImage() -> UIImage {
        //  Hide toolbar and navbar
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.isToolbarHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = false
        return memedImage
    }
    func save() {
        // Create the meme
       // _ = topField.text ?? ""
       //_ = bottomField.text ?? ""
       // _ = imageView.image!
        let imageObject = self.generateMemedImage()
       
        let meme = Meme(topText: topField.text!, bottomText: bottomField.text!, originalImage: imageView.image!, memedObject: imageObject)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }}


// text field functions
extension ViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
    
}
// keboard functions:

extension ViewController {
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }}
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
        
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
