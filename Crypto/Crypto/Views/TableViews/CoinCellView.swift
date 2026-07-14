//
//  CoinCellView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct CoinCellView: View {
    
    @StateObject var viewModel: CoinViewModel
    
    var body: some View {
        
        HStack(spacing: 5) {
            
            Text("#\(String(describing: viewModel.coin.marketCapRank ?? 00))")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            CoinImageView(image: viewModel.icon, isLoading: viewModel.isLoading, size: 50)
            
            VStack(alignment: .leading) {
                Text(viewModel.coin.name)
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
                Text(viewModel.coin.symbol.uppercased())
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
            }
            
            
            Spacer()
            
            VStack() {
                Text("\(viewModel.coin.currentPrice.toAmountString)")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(.black)
                
                Text("\(viewModel.coin.priceChangePercentage24H?.toPercentageString ?? "0.0%")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(viewModel.coin.priceChangePercentage24H ?? 0.0 >= 0 ? .green : .red)
            }
            .padding(.trailing, 10)
            
        }
        .task {
                await viewModel.loadIcon()
        }
    }
}

#Preview {
    CoinCellView(
        viewModel: CoinViewModel(
            coin: CoinModelMock.coin,
            coinService: CriptoService(APIClient.shared)
        ))
}
