//
//  FirstViewController.swift
//  PictureText
//
//  Created by Matt Bettinson on 2016-07-19.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class EncodeViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var picData = NSData()
    var picChunkArray : NSMutableArray = []

    enum imagePickerOptions {
        case Camera
        case PhotoLibrary
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        presentImagePicker(imagePickerOptions.Camera)
    }
    
    @IBAction func selectPicture(sender: AnyObject) {
        presentImagePicker(imagePickerOptions.PhotoLibrary)
    }
    
    func presentImagePicker(option: imagePickerOptions) {
        let imagePicker = UIImagePickerController()
        
        if option == imagePickerOptions.Camera {
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                imagePicker.sourceType = .Camera
            }
            else {
                let alert = UIAlertController(title: nil, message: "You don't even have a camera!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Oh yeah...", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: {
                    imagePicker.sourceType = .PhotoLibrary
                })
            }
        }
        
        if option == imagePickerOptions.PhotoLibrary {
           imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let resizedImage = resizeImage(image, newWidth: 200)
        picData = UIImageJPEGRepresentation(resizedImage, 0.2)!
        
        UIPasteboard.generalPasteboard().string = picData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
        let alert = UIAlertController(title: "Copied", message: "The string has been copied to your clipboard. Send in iMessage or wherever pictures are blocked and have the recepient decode in the screen to the right.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion:nil)
    }
    
    // From http://stackoverflow.com/questions/31966885/ios-swift-resize-image-to-200x200pt-px
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

