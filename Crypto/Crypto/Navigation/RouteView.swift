//
//  RouteView.swift
//  Crypto
//
//  Created by tiago on 14/07/2026.
//

import SwiftUI

struct RouteView: View {
    let route: Route
    private let factory: AppFactory = AppFactory()
    
    var body: some View {
        switch route {
            
        case .home:
            factory.makeHomeView()
            
        case .wallet:
            factory.makeWalletListView()
            
        case .coinDetail(let coin):
            factory.makeCoinDetailView(coin: coin)
            
        }
    }
}

#Preview {
    RouteView(route:.home)
}
