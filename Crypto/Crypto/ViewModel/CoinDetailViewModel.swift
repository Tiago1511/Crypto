//
//  CoinDetailViewModel.swift
//  Crypto
//
//  Created by tiago on 15/02/2026.
//

import Foundation
import Combine
import SwiftUI

class CoinDetailViewModel: ObservableObject {
    
    @Published var coin: CoinModel
    @Published var coinImage: UIImage?
    
    private let coinService: CriptoService
    
    init(coin: CoinModel, coinService: CriptoService) {
        self.coin = coin
        self.coinService = coinService
    }
    
    func fetchImage() async {
        do {
            coinImage = try await coinService.getImage(coin.image)
        } catch {
            print("Error fetching image: \(error)")
        }
    }
}
