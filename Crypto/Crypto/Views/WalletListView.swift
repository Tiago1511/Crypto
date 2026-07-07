//
//  WalletView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct WalletListView: View {
    
    @ObservedObject var viewModel: WalletViewModel
    
    @State private var showPopOver = false
       
       /*var body: some View {
           Button("Apagar item") {
               showPopOver = true
           }
           .sheet(isPresented: $showPopOver) {
               CustomPopOver(
                   title: "Tens a certeza?",
                   message: "Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.Esta ação não pode ser revertida.",
                   confirmTitle: "Apagar",
                   cancelTitle: "Cancelar",
                   onConfirm: {
                       showPopOver = false
                       // lógica de confirmação aqui
                       print("Confirmado!")
                   },
                   onCancel: {
                       showPopOver = false
                       print("Cancelado!")
                   }
               )
               .presentationDetents([.large])
               .presentationDragIndicator(.visible)
           }
       }*/
    
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
