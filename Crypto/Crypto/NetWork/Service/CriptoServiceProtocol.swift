//
//  CriptoServiceProtocol.swift
//  Crypto
//
//  Created by tiago on 15/07/2026.
//

import Foundation
import UIKit

/// Abstraction over `CriptoService` so ViewModels depend on a protocol instead of a
/// concrete network type. This is what allows `HomeViewModel` / `CoinViewModel` to be
/// unit tested with a fake service instead of hitting the real network.
@MainActor
protocol CriptoServiceProtocol {
    func getImage(_ url: String) async throws -> UIImage?
    func getCoins() async throws -> [CoinModel]
}
