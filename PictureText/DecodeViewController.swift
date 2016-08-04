//
//  SecondViewController.swift
//  PictureText
//
//  Created by Matt Bettinson on 2016-07-19.
//  Copyright © 2016 Matt Bettinson. All rights reserved.
//

import UIKit

class DecodeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var copyTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.userInteractionEnabled = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        copyTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func clear(sender: AnyObject) {
        copyTextField.text = ""
        clearButton.enabled = false
    }
    
    @IBAction func convert(sender: AnyObject) {
        if copyTextField.text != "" {
            let string = copyTextField.text
            
            if let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters) {
                let image = UIImage(data: data)
                imageView.image = image
                dismissKeyboard()
                imageView.userInteractionEnabled = true
            } else {
                popInvalidAlert("Data is invalid. Are you sure you didn't delete anything?")
            }
        } else {
            popInvalidAlert("You didn't input anything.")
        }
    }
    
    
    //Makes image full screen
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(DecodeViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        
        dismissKeyboard()
        UIApplication.sharedApplication().statusBarHidden = true
        newImageView.alpha = 0
        self.view.addSubview(newImageView)
        UIView.animateWithDuration(0.3, animations: {
            newImageView.alpha = 1
            self.tabBarController?.tabBar.alpha = 0
        })
    }
    
    func textViewDidChange(textView: UITextView) {
        if textView.text == "" {
            clearButton.enabled = false
        } else {
            clearButton.enabled = true
        }
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        
        UIApplication.sharedApplication().statusBarHidden = false
        self.tabBarController?.tabBar.hidden = false
        
        UIView.animateWithDuration(0.3, animations: { 
            sender.view?.alpha = 0
            self.tabBarController?.tabBar.alpha = 1
            }, completion: {(finished: Bool) -> Void in
            sender.view?.removeFromSuperview()
        })
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

