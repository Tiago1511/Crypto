//
//  CriptoViewModel.swift
//  Crypto
//
//  Created by tiago on 14/02/2026.
//

import Foundation
import Combine
import UIKit

@MainActor
class CoinViewModel: ObservableObject {
    
    @Published var coin: CoinModel
    @Published var icon: UIImage? = nil
    
    private let coinService: CriptoService
    
    init(coin: CoinModel, coinService: CriptoService) {
        self.coin = coin
        self.coinService = coinService
    }
    
    func loadIcon() async {
        do {
            icon = try await coinService.getImage(coin.image)
        } catch {
            print(error)
        }
    }
}
