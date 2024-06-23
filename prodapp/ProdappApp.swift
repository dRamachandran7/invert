//
//  prodappApp.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 12/28/23.
//

import SwiftUI
import UIKit
import MijickPopupView

@main struct ProdappApp: App {
    
    @StateObject var store = JobStore()
    var body: some Scene {
        WindowGroup {
            ContentView(jobs: $store.jobs){
                Task {
                    do {
                        try await store.save(jobs: store.jobs)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
                
            }.implementPopupView(config: configurePopup)
                .task{
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                }
            }
        }
    }
}
private extension ProdappApp {
    func configurePopup(_ config: GlobalConfig) -> GlobalConfig { config
        .top { $0
            .cornerRadius(24)
            .dragGestureEnabled(true)
        }
        .centre { $0
            .tapOutsideToDismiss(true)
        }
        .bottom { $0
            .cornerRadius(24)
            .stackLimit(4)
        }
    }
}
