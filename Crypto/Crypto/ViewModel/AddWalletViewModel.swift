//
//  AddWalletViewModel.swift
//  Crypto
//
//  Created by tiago on 26/02/2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class AddWalletViewModel: ObservableObject {
    
    let coin: CoinModel
    let coinImage: UIImage?
    
    @Published var quantityString: String = "" {
        didSet {
            isValidQuantity = validateQuantity()
            valueEstimated = quantity * coin.currentPrice
        }
    }
    
    @Published var isValidQuantity: Bool = true
    @Published var valueEstimated: Double = 0.0
    
    var quantity: Double {
        Double(quantityString.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
    
    //MARK: - Init
    init(coin: CoinModel, coinImage: UIImage?, quantity: Double = 0.0) {
        self.coin = coin
        self.coinImage = coinImage
        self.quantityString = quantity == 0.0 ? "" : String(quantity)
        isValidQuantity = true
    }
    
    //MARK: - Validate
    func validateQuantity() -> Bool {
        Double(quantityString.replacingOccurrences(of: ",", with: ".")) != nil
    }
    
    //MARK: - Add Wallet
    
    func addWallet() {
        
    }
}
