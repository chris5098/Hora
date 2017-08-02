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

    
    @IBOutlet weak var priceRangeSelector: UISegmentedControl!
    @IBOutlet weak var watchesCollectionView: UICollectionView!
    
    
    var allWatches = [Watch]()
    var filteredWatches = [Watch]()
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltered = false
   // var lowToHigh =
    //var highToLow =


    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiToContact = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens-watches?&fl=p16&offset=0&limit=50"
        /*
        let apiToContact = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens-watch&offset=0&limit=50"
        let apiToContact1 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens-watch&offset=50&limit=50"
        let apiToContact2 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=100&limit=50"
        let apiToContact3 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=150&limit=50"
        let apiToContact4 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=200&limit=50"
        let apiToContact5 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=250&limit=50"
        let apiToContact6 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=300&limit=50"
        let apiToContact7 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=350&limit=50"
        let apiToContact8 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=400&limit=50"
        let apiToContact9 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=450&limit=50"
        let apiToContact10 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=500&limit=50"
        let apiToContact11 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=550&limit=50"
        let apiToContact12 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=600&limit=50"
        let apiToContact13 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=650&limit=50"
        let apiToContact14 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=700&limit=50"
        let apiToContact15 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=750&limit=50"
        let apiToContact16 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=800&limit=50"
        let apiToContact17 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=850&limit=50"
        let apiToContact18 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=1000&limit=50"
        let apiToContact19 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=1050&limit=50"
        let apiToContact20 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=1100&limit=50"
        let apiToContact21 = "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=1150&limit=50"
        let apiToContact22 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=1200&limit=50"
        let apiToContact23 =  "https://api.shopstyle.com/api/v2/products?pid=uid5600-39643660-67&fts=mens+watch&offset=1250&limit=50"
        */
      
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
                    self.filterContentForSearchText(searchText: "")
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
            var watch: Watch
            if searchController.isActive {
                watch = filteredWatches[indexPath.item]
            } else {
                watch = allWatches[indexPath.item]
            }
            //let watch = allWatches[indexPath.item]
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
        //switch priceRangeSelector.selectedSegmentIndex {
        //case 0:
         //   lowToHigh = filteredWatches.sorted { $0.price < $1.price }
        //case 1:
          //  highToLow = filteredWatches.sorted { $0.price < $1.price }
        //default:
         //   break
        //r}
        //filteredWatches = filteredWatches.sorted { $0.price < $1.price }
        watchesCollectionView.reloadData()
    }
}

extension CollectionOfItemsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredWatches.count
        } else {
            return allWatches.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchCellIdentifier", for: indexPath) as! ItemCollectionViewCell
        //let watch = filteredWatches[indexPath.item]
        var watch: Watch
        if searchController.isActive {
            watch = filteredWatches[indexPath.item]
        } else {
            watch = allWatches[indexPath.item]
        }
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

