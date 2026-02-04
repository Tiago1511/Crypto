//
//  ContentView.swift
//  Crypto
//
//  Created by tiago on 03/02/2026.
//

import SwiftUI

struct TabBar: View {
    
    var body: some View {
        
        TabView() {
           
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            WalletListView()
                .tabItem {
                    Label("Wallet", systemImage: "wallet.bifold.fill")
                }
        }
    }
}

#Preview {
    TabBar()
}
