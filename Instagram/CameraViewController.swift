//
//  CameraViewController.swift
//  Instagram
//
//  Created by Neha Swamy on 11/13/19.
//  Copyright © 2019 Neha Swamy. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submit(_ sender: Any) {
        let post = PFObject(className: "Posts")
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        let df = DateFormatter()
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                
            }
        }
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: self.view.frame.width, height: self.view.frame.width)
        let scaledImage = image.af_imageAspectScaled(toFit: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
}
