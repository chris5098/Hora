//
//  HomeViewController.swift
//  Hōra
//
//  Created by Gun Cho on 7/18/17.
//  Copyright © 2017 Gun Cho. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController {

    var allWatches: [Watch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


