//
//  GestureLogger.swift
//  swift_gesture
//
//  Created by weida on 2026/10/19.
//


import Foundation
import Combine

final class GestureLogger: ObservableObject {
    @Published var latestEvent = "Waiting for gestures..."
    @Published var logs: [String] = []

    private let maxLogs = 100

    func log(_ message: String) {
        // Output to the Xcode console
        print("[Gesture] \(message)")

        // Update the SwiftUI interface
        DispatchQueue.main.async {
            self.latestEvent = message
            self.logs.insert(message, at: 0)

            if self.logs.count > self.maxLogs {
                self.logs.removeLast(
                    self.logs.count - self.maxLogs
                )
            }
        }
    }

    func clear() {
        DispatchQueue.main.async {
            self.latestEvent = "Waiting for gestures..."
            self.logs.removeAll()
        }

        print("[Gesture] Logs cleared")
    }
}


