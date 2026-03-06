//
//  WalletViewModel.swift
//  Crypto
//
//  Created by tiago on 06/03/2026.
//

import Foundation
import Combine

@MainActor
class WalletViewModel: ObservableObject {
    
    var coins: [CoinSwiftData] = []
    
    var totalValue: Double = 0.0
    
    var coinSelected: CoinSwiftData?
}
