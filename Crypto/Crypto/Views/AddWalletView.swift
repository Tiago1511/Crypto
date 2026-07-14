//
//  WalletAddView.swift
//  Crypto
//
//  Created by tiago on 04/02/2026.
//

import SwiftUI
import SwiftData

struct AddWalletView: View {
    
    @ObservedObject var viewModel: AddWalletViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        VStack(alignment:.leading, spacing: 20){
            
            headerView
        
            bodyView
            
            Button("Add Wallet") {
                viewModel.addWallet(modelContext: modelContext)
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
        .alert(item: $viewModel.alertItem) { error in
            alert(for: error)
        }
        
    }
    
    private var headerView: some View {
        VStack () {
            HStack() {
                CoinImageView(image: viewModel.coinImage, isLoading: viewModel.isLoading)
                
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
        .task {
                await viewModel.loadIcon()
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
                errorMessage: NSLocalizedString("InvalidQuantity", comment: "Label displayed after the text field to identify the amount of cryptocurrency that is incorrect."),
                isValid: viewModel.isValidQuantity
            )
            
            HStack {
                Text("ToatalValue:")
                Spacer()
                Text(viewModel.valueEstimated.toAmountString)
                
            }
        }
    }
    
    private func alert(for item: AlertItem) -> Alert {
        switch item.kind {
        case .coinAlreadyExists:
            return Alert(
                title: Text(item.title),
                message: Text(item.message),
                primaryButton: .default(Text(NSLocalizedString("goToWallet", comment: ""))) {
                    //router.switchTab(to: .wallet, resetPath: true, resetActualTab: true)
                },
                secondaryButton: .cancel(Text(NSLocalizedString("Cancel", comment: "")))
            )
        case .invalidData:
            return Alert(
                title: Text(item.title),
                message: Text(item.message),
                dismissButton: .default(Text("OK"))
            )
            
        default:
            return Alert(
                title: Text(item.title),
                message: Text(item.message),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
}

#Preview {
    
    let config = ModelConfiguration(
        isStoredInMemoryOnly: true
    )
    
    let container = try! ModelContainer(
        for: CoinSwiftData.self,
        configurations: config
    )
    
    let repository = WalletRepository(
        context: container.mainContext
    )
    
    AddWalletView(
        viewModel: AddWalletViewModel(
            coin: CoinModelMock.coin,
            coinService: CriptoService(APIClient.shared),
            repository: repository
        )
    )
}
