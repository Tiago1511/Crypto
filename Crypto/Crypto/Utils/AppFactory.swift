//
//  AppFactory.swift
//  Crypto
//
//  Created by tiago on 14/07/2026.
//

import Foundation

@MainActor
final class AppFactory {

    private let apiClient = APIClient.shared

    func makeHomeView() -> HomeView {
        HomeView(
            viewModel: HomeViewModel(
                CriptoService(self.apiClient)
            )
        )
    }
    
    func makeWalletListView() -> WalletListView {
        WalletListView(
            viewModel: WalletViewModel()
        )
    }
    
    func makeCoinDetailView(coin: CoinDetailViewModel) -> CoinDetailView {
        CoinDetailView(
            viewModel: coin
        )
    }
    
}
