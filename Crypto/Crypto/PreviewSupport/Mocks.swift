//
//  Mocks.swift
//  Crypto
//
//  Created by tiago on 15/07/2026.
//
//  Lightweight fakes conforming to the app's protocols. Used by SwiftUI `#Preview`s
//  (so previews never hit the real network/database) and by CryptoTests (so unit
//  tests are fast, deterministic, and offline). This is the payoff of the
//  protocol-oriented DI setup: every dependency can be swapped for one of these.

import Foundation
import SwiftData
import UIKit

// MARK: - Mock CriptoService

final class MockCriptoService: CriptoServiceProtocol {
    var coinsToReturn: [CoinModel] = [CoinModelMock.coin]
    var imageToReturn: UIImage? = nil
    var errorToThrow: Error? = nil
    private(set) var getCoinsCallCount = 0

    func getImage(_ url: String) async throws -> UIImage? {
        if let errorToThrow { throw errorToThrow }
        return imageToReturn
    }

    func getCoins() async throws -> [CoinModel] {
        getCoinsCallCount += 1
        if let errorToThrow { throw errorToThrow }
        return coinsToReturn
    }
}

// MARK: - Mock CoinDetailsService

final class MockCoinDetailsService: CoinDetailsServiceProtocol {
    var historicToReturn: HistoricalChartModel = HistoricalChartModelMock.chartData
    var imageToReturn: UIImage? = nil
    var errorToThrow: Error? = nil

    func getImage(_ url: String) async throws -> UIImage? {
        if let errorToThrow { throw errorToThrow }
        return imageToReturn
    }

    func getHistoric(forCoinId id: String) async throws -> HistoricalChartModel {
        if let errorToThrow { throw errorToThrow }
        return historicToReturn
    }
}

// MARK: - Mock WalletRepository

final class MockWalletRepository: WalletRepositoryProtocol {
    var coins: [CoinSwiftData] = []
    var errorToThrow: RepositoryError? = nil

    func fetchPortfolio() throws -> [CoinSwiftData] {
        if let errorToThrow { throw errorToThrow }
        return coins
    }

    func save(coinID: String, name: String, quantity: Double) throws {
        if let errorToThrow { throw errorToThrow }
        if coins.contains(where: { $0.coinID == coinID }) {
            throw RepositoryError.dataAlreadyExists
        }
        coins.append(CoinSwiftData(coinID: coinID, name: name, quantity: quantity))
    }

    func delete(coinID: String) throws {
        if let errorToThrow { throw errorToThrow }
        guard let index = coins.firstIndex(where: { $0.coinID == coinID }) else {
            throw RepositoryError.notFound
        }
        coins.remove(at: index)
    }

    func update(coinID: String, quantity: Double) throws {
        if let errorToThrow { throw errorToThrow }
        guard let coin = coins.first(where: { $0.coinID == coinID }) else {
            throw RepositoryError.notFound
        }
        coin.quantity = quantity
    }
}

// MARK: - Mock DependencyContainer

@MainActor
final class MockDependencyContainer: DependencyContainer {
    let apiClient: APIClientProtocol = APIClient.shared

    var criptoService: CriptoServiceProtocol = MockCriptoService()
    var coinDetailsService: CoinDetailsServiceProtocol = MockCoinDetailsService()
    var walletRepository: WalletRepositoryProtocol = MockWalletRepository()

    func makeCriptoService() -> CriptoServiceProtocol { criptoService }
    func makeCoinDetailsService() -> CoinDetailsServiceProtocol { coinDetailsService }
    func makeWalletRepository(context: ModelContext) -> WalletRepositoryProtocol { walletRepository }
}
