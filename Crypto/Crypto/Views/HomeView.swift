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
        NavigationStack(){
            VStack {
                List(viewModel.filteredCoins, id: \.id){ coin in
                    NavigationLink(
                        destination: CoinDetailView(),
                        label: {
                            CoinCellView(viewModel: viewModel.createCoinViewModel(coin))
                        })
                }
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer, prompt: "SearchCoins")
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.backgroundCl
                    .ignoresSafeArea(.all)
            )
            .navigationTitle("Coins")
            .task {
                await viewModel.fetchCoins()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel( CriptoService(APIClient.shared)))
}
