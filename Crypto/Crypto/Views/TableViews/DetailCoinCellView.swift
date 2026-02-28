//
//  DetailCoinCellView.swift
//  Crypto
//
//  Created by tiago on 26/02/2026.
//

import SwiftUI

struct DetailCoinCellView: View {
    
    let detailCoin: DetailCoin
    
    var body: some View {
        HStack {
            Text(detailCoin.title)
            Spacer()
            Text(detailCoin.value)
        }
    }
}

#Preview {
    DetailCoinCellView(detailCoin: DetailCoin(title: "teste", value: "100"))
}
