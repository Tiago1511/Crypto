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
            
            if let uiImage = viewModel.icon {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else if viewModel.isLoading {
                ProgressView()
                    .frame(width: 50, height: 50)
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.accent)
            }
            
            
            VStack(alignment: .leading) {
                Text(viewModel.coin.name)
                    .font(.title)
                    .fontWeight(.regular)
                Text(viewModel.coin.symbol)
                    .font(.title3)
                    .fontWeight(.regular)
            }
            
            
            Spacer()
            
            VStack() {
                Text("\(viewModel.coin.currentPrice.toAmountString)")
                    .font(.title3)
                    .fontWeight(.regular)
                
                Text("\(viewModel.coin.priceChangePercentage24H?.toPercentageString ?? "0.0%")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(viewModel.coin.currentPrice >= 0 ? .green : .red)
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
