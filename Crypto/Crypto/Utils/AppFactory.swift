//
//  AppFactory.swift
//  Crypto
//
//  Created by tiago on 14/07/2026.
//

import SwiftUI
import SwiftData

/// Builds every screen of the app. This is the *only* place that should ever wire a
/// View to its ViewModel and the ViewModel to its services.
///
/// Because it's a protocol, `RouteView`/`TabBar` don't depend on the concrete
/// `AppFactory` — a test or preview can inject `PreviewAppFactory` (or any other
/// conformance) instead, without touching the navigation code.
@MainActor
protocol AppFactoryProtocol {
    func makeHomeView() -> AnyView
    func makeWalletListView(context: ModelContext) -> AnyView
    func makeCoinDetailView(coin: CoinModel) -> AnyView
    func makeAddWalletView(coin: CoinModel, context: ModelContext) -> AnyView
}

/// Production implementation. Receives a `DependencyContainer` via constructor
/// injection instead of reaching for `APIClient.shared` itself — the container is
/// created once, at the composition root (`CryptoApp`), and handed down.
@MainActor
final class AppFactory: AppFactoryProtocol {

    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }

    func makeHomeView() -> AnyView {
        AnyView(
            HomeView(
                viewModel: HomeViewModel(self.container.makeCriptoService())
            )
        )
    }

    func makeWalletListView(context: ModelContext) -> AnyView {
        AnyView(
            WalletListView(
                viewModel: WalletViewModel(
                    repository: container.makeWalletRepository(context: context)
                )
            )
        )
    }

    func makeCoinDetailView(coin: CoinModel) -> AnyView {
        AnyView(
            CoinDetailView(
                viewModel: CoinDetailViewModel(
                    coin: coin,
                    coinService: container.makeCoinDetailsService()
                )
            )
        )
    }

    func makeAddWalletView(coin: CoinModel, context: ModelContext) -> AnyView {
        AnyView(
            AddWalletView(
                viewModel: AddWalletViewModel(
                    coin: coin,
                    coinService: container.makeCriptoService(),
                    repository: container.makeWalletRepository(context: context)
                )
            )
        )
    }
}
