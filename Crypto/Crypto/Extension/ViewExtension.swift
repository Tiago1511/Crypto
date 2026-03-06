//
//  ViewExtensio.swift
//  Crypto
//
//  Created by tiago on 06/03/2026.
//

import Foundation
import SwiftUI

extension View {
    
    /// Close KeyBoard
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}
