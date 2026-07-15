//
//  ContentView.swift
//  Crypto
//
//  Created by tiago on 03/02/2026.
//

import SwiftUI
import SwiftData

struct TabBar: View {

    @State private var router = AppRouter()
    @Environment(\.appFactory) private var factory
    @Environment(\.modelContext) private var modelContext

    var body: some View {

        TabView(selection: $router.selectedTab) {

            //Home
            NavigationStack(path: router.path(for: .home)) {
                factory.makeHomeView()
                    .navigationDestination(for: Route.self) { route in
                        RouteView(route: route)
                    }
            }
            .tabItem {
                Label("Market", systemImage: "house")
            }
            .tag(AppTab.home)

            //Wallet
            NavigationStack(path: router.path(for: .wallet)) {
                factory.makeWalletListView(context: modelContext)
                    .navigationDestination(for: Route.self) { route in
                        RouteView(route: route)
                    }
            }
            .tabItem {
                Label("Wallet", systemImage: "wallet.bifold.fill")
            }
            .tag(AppTab.wallet)
        }
        .environment(router)
    }
}

#Preview {
    TabBar()
        .environment(\.appFactory, AppFactory(container: MockDependencyContainer()))
}
