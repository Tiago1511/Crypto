//
//  CustomTextField.swift
//  Crypto
//
//  Created by tiago on 26/02/2026.
//

import SwiftUI
import Combine

struct CustomTextField: View {
    
    let title: String
    @Binding var text: String
    @Binding var isSecure: Bool
    var keyboardType: UIKeyboardType = .default
    var errorMessage: String?
    @Binding var isValid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                        .padding(5)
                        
                } else {
                    TextField(title, text: $text)
                        .padding(5)
                }
            }
            .keyboardType(keyboardType)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 1)
            )
            
            if !isValid, let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.caption2)
                    .foregroundColor(.red)
            }
        }
    }
    
    private var borderColor: Color {
        if !isValid, errorMessage != nil {
            return .red
        }
        return .gray
    }
}

#Preview {
    CustomTextField(
        title: "Title",
        text: .constant("Text"),
        isSecure: .constant(false),
        errorMessage: "ola",
        isValid: .constant(true)
        
    )
}
