//
//  ContentView.swift
//  swift_gesture
//
//  Created by weida on 2026/6/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var logger = GestureLogger()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header
            HStack {
                Image(systemName: "hand.draw")
                    .font(.title)

                Text("Gesture Debugger")
                    .font(.largeTitle.bold())

                Spacer()

                Button {
                    logger.clear()
                } label: {
                    Label("Clear Logs", systemImage: "trash")
                }
            }

            // Latest event
            GroupBox("Latest Event") {
                Text(logger.latestEvent)
                    .font(.system(.body, design: .monospaced))
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 35,
                        alignment: .leading
                    )
                    .textSelection(.enabled)
            }

            // Trackpad input area
            VStack(alignment: .leading, spacing: 6) {
                Text("Input Area")
                    .font(.headline)

                TrackpadView(logger: logger)
                    .frame(height: 140)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }

            // Event history
            HStack {
                Text("Event History")
                    .font(.headline)

                Spacer()

                Text("\(logger.logs.count) events")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            List {
                ForEach(
                    Array(logger.logs.enumerated()),
                    id: \.offset
                ) { item in
                    Text(item.element)
                        .font(
                            .system(.caption, design: .monospaced)
                        )
                        .textSelection(.enabled)
                }
            }
        }
        .padding()
        .frame(minWidth: 600, minHeight: 600)
    }
}

