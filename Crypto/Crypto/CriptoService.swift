//
//  CriptoService.swift
//  Crypto
//
//  Created by tiago on 14/02/2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class CriptoService: ObservableObject {
    private let apiClient: APIClientProtocol
    
    
    //MARK: - init
    init(_ apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getImage(_ url: String) async throws -> UIImage?{
         try await apiClient.fetchImage(
                endpoint: url,
                headers: nil,
                cachePolicy: .ignoreCache
            )
    }
}
