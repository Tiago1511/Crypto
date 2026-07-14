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
    let kind: Kind
}

enum Kind {
    case coinAlreadyExists
    case invalidData
    case dataBaseError
}

struct AlertContent{
    //MARK: Add Coin
    static let coinAlreadyExist = AlertItem(
        title: NSLocalizedString("Coin Already Exist", comment: "You have this coin"),
        message: NSLocalizedString("CurrencyExistsMessage", comment: ""),
        kind: .coinAlreadyExists
        )
    
    static let coinInvalidData = AlertItem(
        title: NSLocalizedString("InvalidQuantity", comment: "Label displayed after the text field to identify the amount of cryptocurrency that is incorrect."),
        message: NSLocalizedString("invalidQuantityMessage", comment: ""),
        kind: .invalidData
        )
    
    static let dataBaseError = AlertItem(
        title: NSLocalizedString("error", comment: ""),
        message: NSLocalizedString("somethingWentWrongPleaseTryAgain", comment: ""),
        kind: .dataBaseError
    )
    
}
