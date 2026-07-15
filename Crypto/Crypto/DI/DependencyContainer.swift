//
//  DependencyContainer.swift
//  Crypto
//
//  Created by tiago on 15/07/2026.
//

import Foundation
import SwiftData

/// Single source of truth for building the app's services and repositories.
///
/// Every object that talks to "the outside world" (network, disk) is created here,
/// from a protocol, exactly once. Nothing else in the app is allowed to reach for
/// `APIClient.shared` directly anymore — that was the main reason the previous
/// version of the app was hard to unit test: every ViewModel that needed a
/// child ViewModel silently re-created its own singleton-backed service instead of
/// reusing an injected one.
///
/// In production `AppDependencyContainer` is used. In tests / previews you can pass
/// a lightweight `PreviewDependencyContainer` (or any other conforming type) so no
/// real network/database call is ever made.
@MainActor
protocol DependencyContainer {
    var apiClient: APIClientProtocol { get }

    func makeCriptoService() -> CriptoServiceProtocol
    func makeCoinDetailsService() -> CoinDetailsServiceProtocol
    func makeWalletRepository(context: ModelContext) -> WalletRepositoryProtocol
}

@MainActor
final class AppDependencyContainer: DependencyContainer {

    let apiClient: APIClientProtocol

    /// Services are cheap value-less wrappers around `apiClient`, but we still build
    /// them once and hand out the same instance so every screen shares one
    /// image/network cache instead of each ViewModel spinning up its own.
    private lazy var criptoService: CriptoServiceProtocol = CriptoService(apiClient)
    private lazy var coinDetailsService: CoinDetailsServiceProtocol = CoinDetailsService(apiClient)

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func makeCriptoService() -> CriptoServiceProtocol {
        criptoService
    }

    func makeCoinDetailsService() -> CoinDetailsServiceProtocol {
        coinDetailsService
    }

    func makeWalletRepository(context: ModelContext) -> WalletRepositoryProtocol {
        WalletRepository(context: context)
    }
}
