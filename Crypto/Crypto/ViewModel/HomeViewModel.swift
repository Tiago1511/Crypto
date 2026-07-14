//
//  HomeViewModel.swift
//  Crypto
//
//  Created by tiago on 14/02/2026.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var coins: [CoinModel] = [CoinModelMock.coin]
    @Published var searchText = ""
    
    private let coinService: CriptoService
    
    //MARK: - Init
    init(_ service: CriptoService) {
        self.coinService = service
    }
    
    //MARK: - Filter
    var filteredCoins: [CoinModel] {
           guard !searchText.isEmpty else { return coins }
           
           let lowercased = searchText.lowercased()
           
           return coins.filter {
               $0.name.lowercased().contains(lowercased) ||
               $0.symbol.lowercased().contains(lowercased)
           }
       }
    
    //MARK: - View Models
    func createCoinViewModel(_ coin: CoinModel) -> CoinViewModel {
        CoinViewModel(coin: coin, coinService: CriptoService(APIClient.shared))
    }
    
    //MARK: - Services
    func fetchCoins() async {
        do {
            self.coins = try await coinService.getCoins()
        } catch {
            print("Error fetching coins: \(error)")
        }
    }
    
}
