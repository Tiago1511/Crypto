//
//  CustomPopOver.swift
//  Crypto
//
//  Created by tiago on 15/03/2026.
//

import SwiftUI

struct CustomPopOver: View {
    
    var title: String?
    var message: String?
    var confirmTitle: String = "Confirmar"
    var cancelTitle: String = "Cancelar"
    
    var onConfirm: () -> Void
    var onCancel: () -> Void
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            header
            .padding()
            
            content
            .padding()
            
            Spacer()
            
            
            action
            .padding([.horizontal, .bottom], 20)
        }
    }
    
    // MARK: - Header
    private var header: some View {
        HStack {
            Spacer()
            Button(action: onCancel) {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .shadow(color: .gray, radius: 20)
                    .padding(20)
            }
        }
    }
    
    // MARK: - Content
    private var content: some View {
        ViewThatFits {
            contentView
            
            ScrollView{
                contentView
            }
        }
        
        
    }
    @ViewBuilder
    private var contentView: some View {
        
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.orange)
            
            if let title{
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            if let message {
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        
    }
    
    // MARK: - Actions
    private var action: some View {
        VStack(spacing: 12) {
            Button(action: onConfirm) {
                Text(confirmTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            
            Button(action: onCancel) {
                Text(cancelTitle)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .foregroundStyle(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
    }
}

#Preview {
    CustomPopOver(
        title: "Tens a certeza?",
        message: "Esta ação não pode ser revertida.",
        confirmTitle: "Apagar",
        cancelTitle: "Cancelar",
        onConfirm: {
            print("Confirmado!")
        },
        onCancel: {
            print("Cancelado!")
        }
    )
}
