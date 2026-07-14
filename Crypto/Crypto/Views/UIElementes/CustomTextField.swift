//
//  CustomTextField.swift
//  Crypto
//
//  Created by tiago on 26/02/2026.
//

import SwiftUI
import Combine

// MARK: - View Modifier for didmiss keyboard
struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

// MARK: - CustomTextField
struct CustomTextField: View {
    
    let title: String
    @Binding var text: String
    var isSecure: Bool
    var keyboardType: UIKeyboardType = .default
    let errorMessage: String?
    var isValid: Bool
    var maxLength: Int?
    
    @FocusState private var isFocused: Bool
    
    private var showError: Bool {
        !isValid && !isFocused
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Group {
                if isSecure {
                    SecureField(title, text: $text)
                        .padding(5)
                        .focused($isFocused)
                    
                } else {
                    TextField(title, text: $text)
                        .padding(5)
                        .focused($isFocused)
                }
            }
            .keyboardType(keyboardType)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 1)
            )
            .onChange(of: text) { oldValue, newValue in
                // Limit Lenght
                guard let maxLength else { return }
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
            
            if showError, let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.caption2)
                    .foregroundColor(.red)
                
                if let maxLength = maxLength {
                    Text("Lenght :\(text.count)/\(maxLength)")
                        .font(.caption2)
                        .foregroundColor(text.count == maxLength ? .red : .secondary)
                }
            }
        }
    }
    
    private var borderColor: Color {
        if showError && errorMessage != nil {
            return .red
        }
        return Color.accent
    }
}

#Preview {
    CustomTextField(
        title: "Title",
        text: .constant("Text"),
        isSecure: false,
        errorMessage: "ola",
        isValid: true
        
    )
}
