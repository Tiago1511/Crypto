//
//  WalletAddView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct WalletAddView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    var body: some View {
        
        VStack() {
            Text("Wallet Add View")
                .font(.largeTitle)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
                .navigationBarTitle("Add Wallet")
                .navigationBarItems(trailing: Button("Add") {
                    
                }
                                    )
            
            Text("This is the Wallet Add View")
                
        }
        
        
    }
    
   
}

#Preview {
    WalletAddView(viewModel: WalletViewModel())
}
