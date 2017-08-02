//
//  Watch.swift
//  
//
//  Created by Gun Cho on 7/20/17.
//
//

import Foundation
import SwiftyJSON

struct Watch {
    let brandedName: String
    let priceLabel: String
    let unbrandedName: String
    let price: Double
    let largeImageName: String
    let xlargeImageName: String
    let descriptionName: String
    let clickURL: String
    
    init(json: JSON) {
        self.brandedName = json["brandedName"].stringValue
        self.priceLabel = json["priceLabel"].stringValue
        self.unbrandedName = json["unbrandedName"].stringValue
        self.price = json["price"].doubleValue
        self.largeImageName = json["image"]["sizes"]["Large"]["url"].stringValue
        self.xlargeImageName = json["image"]["sizes"]["XLarge"]["url"].stringValue
        self.descriptionName = json["description"].stringValue
        self.clickURL = json["clickUrl"].stringValue
    }
}
