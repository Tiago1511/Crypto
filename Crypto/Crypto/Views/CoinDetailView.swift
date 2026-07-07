//
//  CoinDetailView.swift
//  Crypto
//
//  Created by tiago on 15/02/2026.
//

import SwiftUI
import Charts
import SwiftData

struct CoinDetailView: View {
    
    @ObservedObject var viewModel: CoinDetailViewModel
    @State private var days: Double = 1
    @Environment(\.modelContext) private var modelContext
    private let minDays: Double = 1
    private let maxDays: Double = 365
    
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
        .toolbar{
            ToolbarItem(placement: .topBarTrailing, content: {
                NavigationLink{
                    AddWalletView(viewModel: viewModel.createCoinViewModel(context: modelContext))
                } label : {
                    Label("Add", systemImage: "plus")
                }
            })
        }
    }
    
    private var headerSection: some View {
        VStack (alignment: .leading) {
            HStack {
                CoinImageView(image: viewModel.coinImage, isLoading: viewModel.isLoading, size: 50)
                
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
    
    private var detailsSection: some View {
        List {
            Section {
                chartSection
            }
            
            ForEach(viewModel.details, id: \.self) { detail in
                Section(header: Text(detail.title ?? "")) {
                    ForEach(detail.data, id: \.self) { data in
                        DetailCoinCellView(detailCoin: data)
                    }
                }
            }
        }.scrollDismissesKeyboard(.immediately)
    }
    
    @ViewBuilder
    private var chartSection: some View {
        
        if let chartData = viewModel.chartData, !chartData.dataPoints.isEmpty {
            
            VStack(alignment: .leading) {
                Slider(value: $days, in: minDays...maxDays, step: 1)
                HStack(spacing:0){
                    Text(days<=1 ? NSLocalizedString("Day", comment: "") : NSLocalizedString("Days", comment: ""))
                    Text(": \(Int(days))")
                }
            }.padding(4)
            
            
            Chart(chartData.dataPoints) { item in
                LineMark(
                    x: .value("Data", item.date),
                    y: .value("Price", item.value)
                )
            }
            .chartXScale(
                domain: chartData.firstData...chartData.lastData
            )
            .frame(height: 250)
            
        } else if viewModel.isLoading {
            ProgressView()
                .frame(width: 50, height: 50)
        } else {
            ContentUnavailableView {
                Label("Empty Data", systemImage: "text.page.slash.fill")
            } description: {
                Text("Unable to load prices")
            } actions: {
                Button("Tray Again") {
                    Task { await viewModel.fetchChartData() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(height: 250)
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
