//
//  ContentView.swift
//  Crypto
//
//  Created by tiago on 03/02/2026.
//

import SwiftUI

struct TabBar: View {
    
    @State private var router = AppRouter()
   
    
    var body: some View {
        
        TabView(selection: $router.selectedTab) {
            
            //Home
            NavigationStack(path: router.path(for: .home)) {
                HomeView(viewModel: HomeViewModel( CriptoService(APIClient.shared)))
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
                WalletListView(viewModel: WalletViewModel())
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
}
