//
//  CoinSwiftData.swift
//  Crypto
//
//  Created by tiago on 02/03/2026.
//

import Foundation
import SwiftData

@Model
class CoinSwiftData {
    
    @Attribute(.unique)
    var coinID : String
    var name: String
    var quantity: Double
    
    init(
        coinID: String = "",
        name: String = "",
        quantity: Double = 0.0
    ) {
        self.coinID = coinID
        self.name = name
        self.quantity = quantity
    }
}
