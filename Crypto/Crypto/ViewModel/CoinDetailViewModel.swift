//
//  CoinDetailViewModel.swift
//  Crypto
//
//  Created by tiago on 15/02/2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class CoinDetailViewModel: ObservableObject {
    
    @Published var coin: CoinModel
    @Published var coinImage: UIImage?
    @Published var details: [DetailCoinModel] = []
    @Published var isLoading: Bool = false
    @Published var isLoadingChart: Bool = false
    @Published var chartData: ChartDataModel?
    @Published var isValidDate : Bool = true
    private var historicalData: HistoricalChartModel?
    
    private let coinService: CoinDetailsServiceProtocol
    
    //MARK: - Init
    init(coin: CoinModel, coinService: CoinDetailsServiceProtocol) {
        self.coin = coin
        self.coinService = coinService
        cretateArrayForm()
    }
    
    //MARK: - Service
    func fetchImage() async {
        isLoading = true
        do {
            coinImage = try await coinService.getImage(coin.image)
            isLoading = false
        } catch {
            isLoading = false
            print("Error fetching image: \(error)")
        }
        
    }
    
    func fetchChartData() async {
        isLoadingChart = true
        do {
            // historicalData = try await coinService.getHistoric(forCoinId: coin.id)
            historicalData = HistoricalChartModelMock.chartData
            createChartData()
            isLoadingChart = false
        } catch {
            isLoadingChart = false
            print("Error fetching chart data: \(error)")
        }
    }
    
    //MARK: - Prepare Data
    private func cretateArrayForm(){
        //first
        details.append(DetailCoinModel(
            title:nil,
            data: [
                DetailCoin(
                    title: NSLocalizedString("24hHight", comment: ""),
                    value: coin.high24H?.toAmountString ?? "0.0"),
                DetailCoin(
                    title: NSLocalizedString("24hLow", comment: ""),
                    value: coin.low24H?.toAmountString ?? "0.0")
            ]
        ))
        
        //market Data
        details.append(DetailCoinModel(
            title:NSLocalizedString("marketData", comment: ""),
            data: [
                DetailCoin(
                    title: NSLocalizedString("marketCap", comment: ""),
                    value: coin.marketCap.toAmountString),
                DetailCoin(
                    title: NSLocalizedString("24hVolume", comment: ""),
                    value: coin.totalVolume.toAmountString),
                DetailCoin(
                    title: NSLocalizedString("rank", comment: ""),
                    value: "#\(coin.marketCapRank ?? 0)"
                )
            ]
        ))
        
        //supply
        details.append(DetailCoinModel(
            title: NSLocalizedString("supply", comment: ""),
            data: [
                DetailCoin(
                    title: NSLocalizedString("circulating", comment: ""),
                    value: coin.circulatingSupply?.toAmountString ?? "0.0"),
                DetailCoin(
                    title: NSLocalizedString("totalSupply", comment: ""),
                    value: coin.totalSupply?.toAmountString ?? "0.0"),
                DetailCoin(
                    title: NSLocalizedString("maxSupply", comment: ""),
                    value: coin.maxSupply?.toAmountString ?? "0.0")
            ]
        ))
    }
    
    private func createChartData() {
        
        chartData = ChartDataModel(
            dataPoints: historicalData?.price.map {
                ChartDataPoint(
                    date: Date(timeIntervalSince1970: $0[0] / 1000),
                    value: $0[1]
                )
            } ?? []
        )
        
    }
    
    //MARK: - Validate
    func validateDays (_ days: Int) {
        if days < 1 || days > 365 {
            isValidDate = false
        } else {
            isValidDate = true
        }
    }
}
