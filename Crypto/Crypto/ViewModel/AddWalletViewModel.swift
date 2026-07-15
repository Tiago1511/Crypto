//
//  AddWalletViewModel.swift
//  Crypto
//
//  Created by tiago on 26/02/2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class AddWalletViewModel: ObservableObject {
    
    let coin: CoinModel
    @Published var isLoading: Bool = false
    @Published var coinImage: UIImage?
    @Published var alertItem: AlertItem?
    
    private let repository: WalletRepositoryProtocol
    private let coinService: CriptoServiceProtocol
    
    @Published var quantityString: String = "" {
        didSet {
            isValidQuantity = validateQuantity()
            valueEstimated = quantity * coin.currentPrice
        }
    }
    
    @Published var isValidQuantity: Bool = true
    @Published var valueEstimated: Double = 0.0
    
    var quantity: Double {
        Double(quantityString.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
    
    //MARK: - Init
    init(coin: CoinModel, coinService: CriptoServiceProtocol, quantity: Double = 0.0, repository: WalletRepositoryProtocol) {
        self.coin = coin
        self.coinService = coinService
        self.quantityString = quantity == 0.0 ? "" : String(quantity)
        isValidQuantity = true
        self.repository = repository
    }
    
    //MARK: - Validate
    func validateQuantity() -> Bool {
        guard let quantity = Double(quantityString.replacingOccurrences(of: ",", with: ".")) else {
            return false
        }
        
        if quantity <= 0.0 {
            return false
        }
        
        return true
        
    }
    
    //MARK: - Add Wallet
    func addWallet() {
        if validateQuantity() {
            do {
                try repository.save(coinID: coin.id, name:coin.name, quantity: quantity)
            } catch {
            
                switch error as? RepositoryError {
                    
                case .dataAlreadyExists:
                    alertItem = AlertContent.coinAlreadyExist

                case .invalidData:
                    alertItem = AlertContent.coinInvalidData
                    
                default:
                    alertItem = AlertContent.dataBaseError
                }
            }
        } else {
            alertItem = AlertContent.coinInvalidData
        }
        
    }
    
    //MARK: - Services
    func loadIcon() async {
        guard coinImage == nil else { return }
        isLoading = true
        do {
            coinImage = try await coinService.getImage(coin.image)
            isLoading = true
        } catch {
            print(error)
        }
        isLoading = false
    }
    
}
