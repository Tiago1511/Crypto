//
//  HomeView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredCoins, id: \.id) { coin in
                NavigationLink(value: coin) {
                    CoinCellView(
                        viewModel: viewModel.createCoinViewModel(coin)
                    )
                }
            }
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer,
                        prompt: "SearchCoins")
            .navigationTitle("Coins")
            .navigationDestination(for: CoinModel.self) { coin in
                CoinDetailView(
                    viewModel: viewModel.createCoinDetailViewModel(coin)
                )
            }.background(
                Color.backgroundCl
                .ignoresSafeArea(.all)
                )
            .task {
                await viewModel.fetchCoins()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel( CriptoService(APIClient.shared)))
}
