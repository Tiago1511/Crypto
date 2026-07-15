//
//  CoinDetailsServiceProtocol.swift
//  Crypto
//
//  Created by tiago on 15/07/2026.
//

import Foundation
import UIKit

/// Abstraction over `CoinDetailsService` so `CoinDetailViewModel` can be tested
/// with a fake implementation instead of the real network layer.
protocol CoinDetailsServiceProtocol {
    func getImage(_ url: String) async throws -> UIImage?
    func getHistoric(forCoinId id: String) async throws -> HistoricalChartModel
}
