//
//  CoinDetailView.swift
//  Crypto
//
//  Created by tiago on 15/02/2026.
//

import SwiftUI
import Charts

struct CoinDetailView: View {
    
    @ObservedObject var viewModel: CoinDetailViewModel
    
    var body: some View {
        
        VStack(alignment: .leading){
            headerSection.padding(.leading, 30)
            detailsSection
        }
        .background(
            Color.backgroundCl
        )
        .task {
            await viewModel.fetchImage()
            await viewModel.fetchChartData()
        }
        
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }

    private var headerSection: some View {
        VStack (alignment: .leading) {
            HStack {
                coinImageView
                
                VStack(alignment: .leading) {
                    Text(viewModel.coin.name)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text(viewModel.coin.symbol.uppercased())
                        .font(.title3)
                }
                
                
            }
            
            HStack(spacing: 20) {
                Text(viewModel.coin.currentPrice.toAmountString)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(viewModel.coin.priceChangePercentage24H?.toPercentageString ?? "0.0%")
                    .foregroundStyle(
                        viewModel.coin.priceChangePercentage24H ?? 0 >= 0 ? .green : .red
                    )
            }
        }
    }

    @ViewBuilder
    private var coinImageView: some View {
        if let uiImage = viewModel.coinImage {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        } else if viewModel.isLoading {
            ProgressView()
                .frame(width: 50, height: 50)
        } else {
            Image(systemName: "questionmark")
                .frame(width: 50, height: 50)
                .foregroundStyle(.accent)
        }
    }


    private var detailsSection: some View {
        List {
            Section {
                Chart(viewModel.chartData) { item in
                    LineMark(
                        x: .value("Data", item.date),
                        y: .value("Preço", item.value)
                    )
                }
                .frame(height: 250)
            }

            ForEach(viewModel.details, id: \.self) { detail in
                Section(header: Text(detail.title ?? "")) {
                    ForEach(detail.data, id: \.self) { data in
                        HStack {
                            Text(data.title)
                            Spacer()
                            Text(data.value)
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    CoinDetailView(
        viewModel: CoinDetailViewModel(
            coin: CoinModelMock.coin,
            coinService: CoinDetailsService(APIClient.shared)
        ))
}
