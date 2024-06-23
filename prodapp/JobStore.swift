//
//  TaskStore.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 1/13/24.
//

import Foundation
import SwiftUI

@MainActor
class JobStore: ObservableObject {
    
    @Published var jobs: [Job] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("jobstore.data")
    }
    func load() async throws {
        let task = Task<[Job], Error> {
            let fileURL = try Self.fileURL()
            
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let taskList = try JSONDecoder().decode([Job].self, from: data)
            return taskList
        }
        let jobs = try await task.value
        self.jobs = jobs
    }
    func save (jobs: [Job]) async throws {
        let task = Task{
            let data = try JSONEncoder().encode(jobs)
            let outFile = try Self.fileURL()
            try data.write(to: outFile)
        }
        _ = try await task.value
    }
    func append(jobs: [Job]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(jobs)
            let outFile = try Self.fileURL()

            if let fileHandle = try? FileHandle(forWritingTo: outFile) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(data)
                fileHandle.closeFile()
            } else {
                try data.write(to: outFile)
            }
        }

        _ = try await task.value
    }
}

