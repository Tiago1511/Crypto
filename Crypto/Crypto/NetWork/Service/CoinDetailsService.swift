//
//  CoinDetailsService.swift
//  Crypto
//
//  Created by tiago on 24/02/2026.
//

import Foundation
import SwiftUI
import Alamofire

class CoinDetailsService {
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
                cachePolicy: .useCache
            )
    }
    
    /// get Historic (chart Data)
    func getHistoric(forCoinId id: String) async throws -> HistoricalChartModel {
        try await apiClient.request(
            endpoint: "",
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil,
            cachePolicy: .ignoreCache
            )
            
    }
}
