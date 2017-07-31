//
//  SpecificItemViewController.swift
//  
//
//  Created by Gun Cho on 7/20/17.
//
//

import UIKit
import SwiftyJSON
import Alamofire
import SafariServices

class SpecificItemViewController: UIViewController {
    
    // Outlets and variables
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionName: UITextView!

    
    
    //var allWatches = [Watch]()
    var watch: Watch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let watch = watch {
            let imageURL = URL(string: watch.xlargeImageName)
            if let imageURL = imageURL {
                if let imageData = try? Data(contentsOf: imageURL) {
                    imageView.image = UIImage(data: imageData)
                }
            }
            nameLabel.text = watch.brandedName
            priceLabel.text = watch.priceLabel
            descriptionName.text = watch.descriptionName
         
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // Actions and methods
    
    @IBAction func purchaseButton(_ sender: UIButton) {
        let url = URL(string: (watch?.clickURL)!)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }
    
    
    
    
}

