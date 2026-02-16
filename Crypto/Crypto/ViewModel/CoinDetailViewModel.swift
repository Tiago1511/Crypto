//
//  CoinDetailViewModel.swift
//  Crypto
//
//  Created by tiago on 15/02/2026.
//

import Foundation
import Combine
import SwiftUI

class CoinDetailViewModel: ObservableObject {
    
    @Published var coin: CoinModel
    @Published var coinImage: UIImage?
    @Published var details: [DetailCoinModel] = []
    @Published var isLoading: Bool = false
    
    private let coinService: CriptoService
    
    init(coin: CoinModel, coinService: CriptoService) {
        self.coin = coin
        self.coinService = coinService
        cretateArrayForm()
    }
    
    func fetchImage() async {
        isLoading = true
        defer{
            isLoading = false
        }
        do {
            coinImage = try await coinService.getImage(coin.image)
        } catch {
            print("Error fetching image: \(error)")
        }
        
    }
    
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
}
