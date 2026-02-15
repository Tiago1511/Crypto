//
//  CriptoService.swift
//  Crypto
//
//  Created by tiago on 14/02/2026.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

@MainActor
final class CriptoService: ObservableObject {
    
    private let apiClient: APIClientProtocol
    
    
    //MARK: - init
    init(_ apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    //MARK: - API Calls
    
    /// get Image
    func getImage(_ url: String) async throws -> UIImage?{
         try await apiClient.fetchImage(
                endpoint: url,
                headers: nil,
                cachePolicy: .ignoreCache
            )
    }
    
    /// get Coins
    func getCoins() async throws -> [CoinModel] {
        try await apiClient.request(
            endpoint: "https://api.coingecko.com/api/v3/coins/list",
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            cachePolicy: .ignoreCache
        )
    }
}
