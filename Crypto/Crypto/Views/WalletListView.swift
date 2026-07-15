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
    @State private var coinIDPendingDelete: String?

    var body: some View {
        List {
            Section {
                header
                    .listRowSeparator(.hidden)
            }

            if viewModel.coins.isEmpty {
                ContentUnavailableView(
                    "No coins yet",
                    systemImage: "wallet.bifold",
                    description: Text("Add a coin from the Market tab to start tracking it here.")
                )
            } else {
                ForEach(viewModel.coins, id: \.coinID) { coin in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(coin.name)
                                .font(.headline)
                            Text(coin.quantity.toAmountString)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            coinIDPendingDelete = coin.coinID
                            showPopOver = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .background(
            Color.backgroundCl
                .ignoresSafeArea(.all)
        )
        .navigationTitle("Wallet")
        .task {
            viewModel.loadPortfolio()
        }
        .sheet(isPresented: $showPopOver) {
            CustomPopOver(
                title: "Tens a certeza?",
                message: "Esta ação não pode ser revertida.",
                confirmTitle: "Apagar",
                cancelTitle: "Cancelar",
                onConfirm: {
                    showPopOver = false
                    if let coinIDPendingDelete {
                        viewModel.delete(coinID: coinIDPendingDelete)
                    }
                    coinIDPendingDelete = nil
                },
                onCancel: {
                    showPopOver = false
                    coinIDPendingDelete = nil
                }
            )
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
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
    WalletListView(viewModel: WalletViewModel(repository: MockWalletRepository()))
}
