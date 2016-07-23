//
//  SecondViewController.swift
//  PictureText
//
//  Created by Matt Bettinson on 2016-07-19.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class DecodeViewController: UIViewController {
    
    @IBOutlet weak var copyTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func convert(sender: AnyObject) {
        if copyTextField.text != "" {
            let string = copyTextField.text
            
            if let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters) {
                let image = UIImage(data: data)
                imageView.image = image
                dismissKeyboard()
            } else {
                popInvalidAlert("Data is invalid. Are you sure you didn't delete anything?")
            }
        } else {
            popInvalidAlert("You didn't input anything.")
        }
    }
    
    func popInvalidAlert(text: String) {
        let alert = UIAlertController(title: "Invalid text", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion:nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

