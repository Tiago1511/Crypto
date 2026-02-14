//
//  CoinCellView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct CoinCellView: View {
    
    var coin: CoinModel
    @ObservedObject var viewModel: CoinViewModel
    
    var body: some View {
        
        HStack(spacing: 5) {
            
            Text("#\(String(describing: coin.marketCapRank ?? 00))")
                .font(.title3)
                .fontWeight(.semibold)
            
            if let uiImage = viewModel.icon {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            
            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.title)
                    .fontWeight(.regular)
                Text(coin.symbol)
                    .font(.title3)
                    .fontWeight(.regular)
            }
            
            
            Spacer()
            
            VStack() {
                Text("\(coin.currentPrice.toAmountString)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(coin.currentPrice >= 0 ? .green : .red)
                
                
                Text("\(coin.priceChangePercentage24H?.toPercentageString ?? "0.0%")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(coin.currentPrice >= 0 ? .green : .red)
            }
            .padding(.trailing, 10)
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.backgroundCl
                .ignoresSafeArea(.all)
        )
        .onAppear {
            Task {
                await viewModel.loadIcon()
            }
        }
    }
}

#Preview {
    CoinCellView(
        coin: CoinModelMock.coin,
        viewModel: CoinViewModel(coin: CoinModelMock.coin, coinService: CriptoService(APIClient.shared)))
}
