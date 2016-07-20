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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        picData = UIImageJPEGRepresentation(image, 0.1)!
        
        UIPasteboard.generalPasteboard().string = picData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
        let alert = UIAlertController(title: "Copied", message: "The string has been copied to your clipboard. Send in iMessage or wherever pictures are blocked and have the recepient decode in the screen to the right.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion:nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

