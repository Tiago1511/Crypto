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
    
    var name: String
    var symbol: String
    var image: String
    var price: Double
    var priceChangePercentage24H: Double
    
    init(
        symbol: String = "",
        name: String = "",
        image: String = "",
        price: Double = 0.0,
        priceChangePercentage24H: Double = 0.0
    ) {
        self.symbol = symbol
        self.name = name
        self.image = image
        self.price = price
        self.priceChangePercentage24H = priceChangePercentage24H
    }
}
