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
    @Published var isLoading: Bool = false
    
    private let coinService: CriptoService
    
    init(coin: CoinModel, coinService: CriptoService) {
        self.coin = coin
        self.coinService = coinService
    }
    
    func loadIcon() async {
        guard icon == nil else { return }
        isLoading = true
        do {
            icon = try await coinService.getImage(coin.image)
            isLoading = true
        } catch {
            print(error)
        }
        isLoading = false
    }
}
