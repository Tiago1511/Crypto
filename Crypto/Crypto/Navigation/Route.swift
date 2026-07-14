//
//  Route.swift
//  Crypto
//
//  Created by tiago on 13/07/2026.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case home
    case wallet
    case coinDetail(CoinModel)
}

enum AppTab: Hashable, CaseIterable {
    case home, wallet
}
