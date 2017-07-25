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
    let imageName: String
    
    init(json: JSON) {
        self.brandedName = json["brandedName"].stringValue
        self.priceLabel = json["priceLabel"].stringValue
        self.unbrandedName = json["unbrandedName"].stringValue
        self.imageName = json["image"]["sizes"]["Medium"]["url"].stringValue
    }
}
