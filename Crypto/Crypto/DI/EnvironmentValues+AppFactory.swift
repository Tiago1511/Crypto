//
//  EnvironmentValues+AppFactory.swift
//  Crypto
//
//  Created by tiago on 15/07/2026.
//

import SwiftUI

/// Lets any View read the app-wide `AppFactoryProtocol` via `@Environment(\.appFactory)`
/// instead of instantiating its own `AppFactory()`. Previously `RouteView` and
/// `HomeView` each created a brand new `AppFactory()` (and `AppFactory` itself created
/// a brand new `APIClient.shared`-backed service every time), so every screen ended up
/// with a different, untestable dependency graph. Now there is exactly one factory,
/// built once in `CryptoApp`, shared everywhere.
private struct AppFactoryKey: EnvironmentKey {
    @MainActor static var defaultValue: AppFactoryProtocol = AppFactory(container: AppDependencyContainer(apiClient: APIClient.shared))
}

extension EnvironmentValues {
    var appFactory: AppFactoryProtocol {
        get { self[AppFactoryKey.self] }
        set { self[AppFactoryKey.self] = newValue }
    }
}
