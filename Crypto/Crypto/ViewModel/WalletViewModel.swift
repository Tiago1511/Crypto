//
//  WalletViewModel.swift
//  Crypto
//
//  Created by tiago on 06/03/2026.
//

import Foundation
import Combine

@MainActor
final class WalletViewModel: ObservableObject {

    @Published var coins: [CoinSwiftData] = []
    @Published var totalValue: Double = 0.0
    @Published var coinSelected: CoinSwiftData?
    @Published var alertItem: AlertItem?

    private let repository: WalletRepositoryProtocol

    //MARK: - Init
    init(repository: WalletRepositoryProtocol) {
        self.repository = repository
    }

    //MARK: - Portfolio
    func loadPortfolio() {
        do {
            coins = try repository.fetchPortfolio()
            // NOTE: this is a placeholder total (sum of quantities). Computing a real
            // monetary total needs the coin's current price, which isn't persisted in
            // `CoinSwiftData` - that's a separate, pre-existing gap unrelated to DI.
            totalValue = coins.reduce(0) { $0 + $1.quantity }
        } catch {
            alertItem = AlertContent.dataBaseError
        }
    }

    func delete(coinID: String) {
        do {
            try repository.delete(coinID: coinID)
            loadPortfolio()
        } catch {
            alertItem = AlertContent.dataBaseError
        }
    }
}
