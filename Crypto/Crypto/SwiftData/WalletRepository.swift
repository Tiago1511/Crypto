//
//  File.swift
//  Crypto
//
//  Created by tiago on 04/06/2026.
//

import Foundation
import SwiftData

// MARK: - Wallet Repository Protocol
protocol WalletRepositoryProtocol {
    func fetchPortfolio() throws -> [CoinSwiftData]
    
    func save(
        coinID: String,
        name: String,
        quantity: Double
    ) throws
    
    func delete(
        coinID: String
    ) throws
    
    func update(
        coinID: String,
        quantity: Double
    ) throws
}

// MARK: - Wallet Repository
final class WalletRepository: WalletRepositoryProtocol {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    /// Fetches all saved coins from the database to represent the user's portfolio.
    ///
    /// - Returns: An array of `CoinSwiftData` objects currently stored in the context.
    /// - Throws: `RepositoryError.databaseFailure` if the fetch operation fails.
    func fetchPortfolio() throws -> [CoinSwiftData] {
        
        let descriptor = FetchDescriptor<CoinSwiftData>()
        
        do {
            return try context.fetch(descriptor)
        } catch {
            throw RepositoryError.databaseFailure(underlyingError: error)
        }
    }
    
    /// Saves a new coin to the repository if it does not already exist.
    ///
    /// - Parameters:
    ///   - coinID: The unique identifier for the coin.
    ///   - name: The name of the cryptocurrency.
    ///   - quantity: The amount of the coin owned.
    /// - Throws: `RepositoryError.dataAlreadyExists` if a coin with the same ID is found,
    ///           `RepositoryError.databaseFailure` if the database query fails,
    ///           or a SwiftData save error if the persistence operation fails.
    func save(
        coinID: String,
        name: String,
        quantity: Double
    ) throws {
        
        do {
            let _ = try fetchCoin(coinID: coinID)
            
            throw RepositoryError.dataAlreadyExists
            
        } catch RepositoryError.notFound {
            let coin = CoinSwiftData(
                coinID: coinID,
                name: name,
                quantity: quantity
            )
            
            context.insert(coin)
            
            try context.save()
        } catch {
            throw RepositoryError.databaseFailure(underlyingError: error)
        }
        
    }
    
    /// Updates the quantity of an existing coin in the database.
    ///
    /// - Parameters:
    ///   - coinID: The unique identifier of the coin to be updated.
    ///   - quantity: The new amount to assign to the coin.
    /// - Throws: `RepositoryError.notFound` if the coin does not exist,
    ///           or a SwiftData save error if the persistence operation fails.
    func update(
        coinID: String,
        quantity: Double
    ) throws {
        
        var coin = try fetchCoin(coinID: coinID)

        coin.quantity = quantity
        
        try context.save()
        
    }
    
    /// Deletes a specific coin from the database using its unique identifier.
    ///
    /// This method first verifies the existence of the coin. If found, it removes
    /// the record and immediately persists the changes to the SwiftData store.
    ///
    /// - Parameter coinID: The unique identifier of the coin to be deleted.
    /// - Throws: `RepositoryError.notFound` if the coin does not exist,
    ///           `RepositoryError.databaseFailure` if the query fails,
    ///           or a SwiftData save error if persistence fails.
    func delete(
        coinID: String
    ) throws {
        
        let coin = try fetchCoin(coinID: coinID)
        
        context.delete(coin)
        
        try context.save()
    }
    
    /// Fetches a specific coin from the database by its unique identifier.
    ///
    /// - Parameter coinID: The unique identifier of the coin to look for.
    /// - Returns: A `CoinSwiftData` object matching the provided identifier.
    /// - Throws: `RepositoryError.databaseFailure` if the SwiftData fetch operation fails,
    ///           or `RepositoryError.notFound` if no matching record is found.
    func fetchCoin(coinID: String) throws -> CoinSwiftData {
        
        let descriptor = FetchDescriptor<CoinSwiftData>(
            predicate: #Predicate {
                $0.coinID == coinID
            }
        )
        
        let results: [CoinSwiftData]
        
        do {
            results = try context.fetch(descriptor)
        } catch {
            throw RepositoryError.databaseFailure(underlyingError: error)
        }
        
        guard let coin = results.first else {
            throw RepositoryError.notFound
        }
        
        return coin
    }
}
