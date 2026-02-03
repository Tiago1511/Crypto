//
//  ContentView.swift
//  Crypto
//
//  Created by tiago on 03/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea(.all)
            VStack {
                Image(systemName: "globe")
                    .frame(width: 100, height: 100)
                    .imageScale(.large)
                    .foregroundStyle(.accent)
                Text("Hello, world!")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
