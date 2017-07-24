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
    let priceLabel: Double
    
    init(json: JSON) {
        self.brandedName = json["brandedName"].stringValue
        self.priceLabel = json["priceLabel"].doubleValue

    }
}
