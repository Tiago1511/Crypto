//
//  TextFied.swift
//  Crypto
//
//  Created by tiago on 26/02/2026.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    /// Close KeyBoard
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
