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
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func convert(sender: AnyObject) {
        if copyTextField.text != "" {
            let string = copyTextField.text

            let data = NSData(base64EncodedString: string, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
            let image = UIImage(data: data)
            imageView.image = image
        } else {
            let alert = UIAlertController(title: "No text inputted", message: "Please add the text", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion:nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

