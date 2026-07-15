//
//  RouteView.swift
//  Crypto
//
//  Created by tiago on 14/07/2026.
//

import SwiftUI
import SwiftData

struct RouteView: View {
    let route: Route
    
    @Environment(\.appFactory) private var factory
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        switch route {
            
        case .home:
            factory.makeHomeView()

        case .wallet:
            factory.makeWalletListView(context: modelContext)

        case .coinDetail(let coin):
            factory.makeCoinDetailView(coin: coin)

        case .addWallet(let coin):
            factory.makeAddWalletView(coin: coin, context: modelContext)
        }
    }
}

#Preview {
    RouteView(route:.home)
        .environment(\.appFactory, AppFactory(container: MockDependencyContainer()))
        .environment(AppRouter())
}
