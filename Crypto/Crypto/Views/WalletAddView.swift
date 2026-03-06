//
//  WalletAddView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI

struct WalletAddView: View {
    
    @ObservedObject var viewModel: AddWalletViewModel
    
    var body: some View {
        
        VStack(spacing: 20){
            
            headerView
        
            bodyView
            
            Button("Add Wallet") {
                viewModel.addWallet()
            }
            .frame(maxWidth: .infinity)
            .padding(20)
                .background(Color.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.backgroundCl
                .ignoresSafeArea(.all)
        )
        .dismissKeyboardOnTap()
        
    }
    
    private var headerView: some View {
        VStack () {
            HStack() {
                CoinImageView(image: viewModel.coinImage, isLoading: false)
                
                VStack(alignment: .leading) {
                    Text(viewModel.coin.name)
                        .font(.title)
                        .fontWeight(.regular)
                    Text(viewModel.coin.symbol.uppercased())
                        .font(.title3)
                        .fontWeight(.regular)
                }
            }
            Text(viewModel.coin.currentPrice.toAmountString)
        }
    }
    
    private var bodyView: some View {
        VStack(alignment: .leading) {
            Text("Quantity")
            CustomTextField(
                title: NSLocalizedString("Quantity", comment: "A label displayed above the text field for entering the quantity of a cryptocurrency."),
                text: $viewModel.quantityString,
                isSecure: false,
                keyboardType: .numberPad,
                errorMessage: "Invalid Quantity",
                isValid: viewModel.isValidQuantity
            )
            
            HStack {
                Text("ToatalValue:")
                Spacer()
                Text(viewModel.valueEstimated.toAmountString)
                
            }
        }
    }
    
}

#Preview {
    WalletAddView(
        viewModel: AddWalletViewModel(
            coin: CoinModelMock.coin,
            coinImage: UIImage(named: "AppIcon")
        )
    )
}
