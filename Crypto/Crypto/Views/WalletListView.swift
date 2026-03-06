//
//  WalletView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct WalletListView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    
    
    var body: some View {
        Text("Wallet")

        
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Wallet")
                .font(.largeTitle)
                .bold()
            Text(viewModel.totalValue.toAmountString)
                .font(.title2)
        }
    }
}

#Preview {
    WalletListView(viewModel: WalletViewModel())
}
