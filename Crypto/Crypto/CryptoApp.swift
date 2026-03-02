//
//  CryptoApp.swift
//  Crypto
//
//  Created by tiago on 03/02/2026.
//

import SwiftUI
import SwiftData

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: CoinSwiftData.self)
    }
    
    init () {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
