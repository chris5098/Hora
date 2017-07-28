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
        
        
       
        /*
        let apiToContact = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=0&limit=10"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let items = json["products"].arrayValue
                    for item in items {
                        self.allWatches.append(Watch(json: item))
                    }
                    
                     for watch in self.allWatches {
                     print(watch.brandedName)
                     }
 
                    DispatchQueue.main.async {
                        self.nameLabel.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
 
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // Actions and methods
    @IBAction func purchaseButton(_ sender: UIButton) {
        let url = URL(string: (watch?.clickURL)!)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
    }



/*
extension SpecificItemViewController: UI {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allWatches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchCellIdentifier", for: indexPath) as! ItemCollectionViewCell
        let watch = allWatches[indexPath.item]
        cell.nameLabel.text = watch.brandedName
        cell.priceLabel.text = watch.priceLabel
        let imageURL = URL(string: watch.imageName)
        if let imageURL = imageURL {
            if let imageData = try? Data(contentsOf: imageURL) {
                cell.watchImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
 */
}

