//
//  HomeView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    @Environment(AppRouter.self) var router
    private let factory: AppFactory = AppFactory()
    
    var body: some View {
        List(viewModel.filteredCoins, id: \.id) { coin in
            Button {
                router.push(.coinDetail(coin))
            } label: {
                CoinCellView(
                    viewModel: viewModel.createCoinViewModel(coin)
                )
            }
        }
        .searchable(text: $viewModel.searchText,
                    placement: .navigationBarDrawer,
                    prompt: "SearchCoins")
        .navigationTitle("Coins")
        
        .background(
            Color.backgroundCl
                .ignoresSafeArea(.all)
        )
        .task {
            await viewModel.fetchCoins()
        }
        
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel( CriptoService(APIClient.shared)))
        .environment(AppRouter())
}
