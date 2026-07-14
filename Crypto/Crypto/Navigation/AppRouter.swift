//
//  AppRouter.swift
//  Crypto
//
//  Created by tiago on 13/07/2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
@Observable
final class AppRouter {
    
    var selectedTab: AppTab = .home
    
    var paths: [AppTab: NavigationPath] = [
        .home: NavigationPath(),
        .wallet: NavigationPath()
    ]
    
    func push(_ route: Route, in tab: AppTab? = nil) {
        let target = tab ?? selectedTab
        paths[target, default: NavigationPath()].append(route)
    }
    
    func pop(in tab: AppTab? = nil) {
        let target = tab ?? selectedTab
        if !(paths[target]?.isEmpty ?? true) {
            paths[target]?.removeLast()
        }
    }
    
    func popToRoot() {
        paths[selectedTab] = NavigationPath()
    }
    
    func switchTab(to tab: AppTab, resetPath: Bool = false, resetActualTab: Bool = false) {
        if resetPath {
            paths[tab] = NavigationPath()
        }
        
        if resetActualTab {
            paths[selectedTab] = NavigationPath()
        }
        
        selectedTab = tab
    }
    
    func path(for tab: AppTab) -> Binding<NavigationPath> {
        Binding(
            get: { self.paths[tab, default: NavigationPath()] },
            set: { self.paths[tab] = $0 }
        )
    }
}
