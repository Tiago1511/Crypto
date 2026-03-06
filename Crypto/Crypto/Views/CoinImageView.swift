//
//  CoinImage.swift
//  Crypto
//
//  Created by tiago on 06/03/2026.
//

import SwiftUI

struct CoinImageView: View {
    
    var image: UIImage?
    var isLoading: Bool
    var size: CGFloat = 50
    
    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.accent)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

#Preview {
    CoinImageView(image: UIImage(named: "AppIcon"), isLoading: false, size: 50)
}
