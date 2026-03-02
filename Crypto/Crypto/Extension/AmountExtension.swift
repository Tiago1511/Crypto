//
//  CurrencyExtencion.swift
//  Crypto
//
//  Created by tiago on 14/02/2026.
//

import Foundation

extension Double {
    
    /// Formate a double into a currency with 2-6 decimal places
    private var toAmount: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        formatter.locale = Locale.current
        return formatter
    }
    
    /// Formate a double into a percentage with 2-6 decimal places
    private var toPercentage: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        formatter.multiplier = 100
        formatter.percentSymbol = "%"
        return formatter
    }
    
    /// Converte amount  into  formated string with 2-6 decimal places
    public var toAmountString: String {
        toAmount.string(from: NSNumber(value: self)) ?? "0.00"
    }
    
    /// Converte percentage into formated string with 2-6 decimal places
    public var toPercentageString: String {
        toPercentage.string(from: NSNumber(value: self)) ?? "0.00%"
    }
}
