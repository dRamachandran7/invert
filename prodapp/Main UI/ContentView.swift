//
//  ContentView.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store = JobStore()
    @Binding var jobs: [Job]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        
        JobMenu(jobs: $jobs){
            Task {
                do {
                    try await store.save(jobs: jobs)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            
        }
            .task{
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
            }
        }
    
        .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
        }
    }
}


#Preview {
    ContentView(jobs: .constant((Job.sampleData)), saveAction: {})
}
