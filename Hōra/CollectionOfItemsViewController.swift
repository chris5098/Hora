//
//  CollectionOfItemsViewController.swift
//  
//
//  Created by Gun Cho on 7/20/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class CollectionOfItemsViewController: UIViewController {

    @IBOutlet weak var watchesCollectionView: UICollectionView!
    
    var allWatches = [Watch]()
    var filteredWatches = [Watch]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let apiToContact = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=5000&limit=50"
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let items = json["products"].arrayValue
                    for item in items {
                        self.allWatches.append(Watch(json: item))
                    }
                    /*
                    DispatchQueue.main.async {
                        self.watchesCollectionView.reloadData()
                    }
                    */
                }
            case .failure(let error):
                print(error)
            }
        }
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.autocapitalizationType = .none
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWatch" {
            let indexPath = watchesCollectionView.indexPathsForSelectedItems![0]
            let watch = allWatches[indexPath.item]
            let specificItemViewController = segue.destination as! SpecificItemViewController
            specificItemViewController.watch = watch
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredWatches = allWatches.filter { watch in
            let trimmedString = searchText.trimmingCharacters(in: CharacterSet.whitespaces).lowercased()
            if trimmedString.characters.count > 0 {
                return watch.brandedName.lowercased().hasPrefix(trimmedString)
            }
            return false
        }
        watchesCollectionView.reloadData()
    }
}

extension CollectionOfItemsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredWatches.count
        //return allWatches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchCellIdentifier", for: indexPath) as! ItemCollectionViewCell
        let watch = filteredWatches[indexPath.item]
        //let watch = allWatches[indexPath.item]
        cell.nameLabel.text = watch.brandedName
        cell.priceLabel.text = watch.priceLabel
        let imageURL = URL(string: watch.xlargeImageName)
        if let imageURL = imageURL {
            if let imageData = try? Data(contentsOf: imageURL) {
                cell.watchImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
}

extension CollectionOfItemsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(searchText: text)
        }
    }
}

