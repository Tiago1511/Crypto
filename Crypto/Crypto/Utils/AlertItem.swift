//
//  AlertItem.swift
//  Crypto
//
//  Created by tiago on 01/07/2026.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id: UUID = UUID()
    let title: String
    let message: String
    let primaryButton: Alert.Button?
    let dismissButton: Alert.Button
}

struct AlertContent{
    //MARK: Add Coin
    static let coinAlreadyExist = AlertItem(
        title: NSLocalizedString("Coin Already Exist", comment: "You have this coin"),
        message: NSLocalizedString("CurrencyExistsMessage", comment: ""),
        primaryButton: .default(Text("goToWallet")),
        dismissButton: .cancel(Text("OK")))
    
    static let coinInvalidData = AlertItem(
        title: NSLocalizedString("Coin Already Exist", comment: "You have this coin"),
        message: NSLocalizedString("goToWallet", comment: ""),
        primaryButton: nil,
        dismissButton: .cancel(Text("OK")))
    
}
