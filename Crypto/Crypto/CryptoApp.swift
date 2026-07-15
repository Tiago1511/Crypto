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

    // MARK: - Composition Root
    //
    // The dependency container and the factory are created exactly once, here,
    // and handed down through the SwiftUI environment. Nothing below this point
    // in the view tree is allowed to build its own `APIClient`, service, or
    // `AppFactory` — that duplication was what made the previous version of the
    // app hard to unit test.
    private let container: DependencyContainer = AppDependencyContainer(apiClient: APIClient.shared)
    private let factory: AppFactoryProtocol

    init() {
        factory = AppFactory(container: container)
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environment(\.appFactory, factory)
        }
        .modelContainer(for: CoinSwiftData.self)
    }
}
