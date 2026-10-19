//
//  TrackpadView.swift
//  swift_gesture
//
//  Created by weida on 2026/10/19.
//

import Foundation

import SwiftUI
import AppKit

struct TrackpadView: NSViewRepresentable {
    @ObservedObject var logger: GestureLogger

    func makeNSView(context: Context) -> GestureNSView {
        let view = GestureNSView()
        view.logger = logger
        return view
    }

    func updateNSView(
        _ nsView: GestureNSView,
        context: Context
    ) {
        nsView.logger = logger
    }
}

final class GestureNSView: NSView {

    var logger: GestureLogger?

    override var acceptsFirstResponder: Bool {
        true
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        window?.acceptsMouseMovedEvents = true
        window?.makeFirstResponder(self)
    }

    // MARK: - Drawing

    override func draw(_ dirtyRect: NSRect) {
        NSColor(
            calibratedRed: 0.08,
            green: 0.09,
            blue: 0.12,
            alpha: 1
        ).setFill()

        dirtyRect.fill()

        let text = """
        Gesture Input Area

        Click here to focus
        Swipe • Pinch • Rotate • Scroll
        """

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: NSColor.white,
            .font: NSFont.systemFont(ofSize: 16)
        ]

        text.draw(
            at: CGPoint(x: 20, y: bounds.midY - 30),
            withAttributes: attributes
        )
    }

    // MARK: - Swipe

    override func swipe(with event: NSEvent) {
        logger?.log(
            "SWIPE | X: \(event.deltaX) | Y: \(event.deltaY)"
        )
    }

    // MARK: - Pinch

    override func magnify(with event: NSEvent) {
        logger?.log(
            "PINCH | Magnification: \(event.magnification)"
        )
    }

    // MARK: - Rotate

    override func rotate(with event: NSEvent) {
        logger?.log(
            "ROTATE | Degrees: \(event.rotation)"
        )
    }

    // MARK: - Smart Zoom

    override func smartMagnify(with event: NSEvent) {
        logger?.log("SMART MAGNIFY")
    }

    // MARK: - Scroll

    override func scrollWheel(with event: NSEvent) {
        logger?.log(
            """
            SCROLL | X: \(event.scrollingDeltaX) | \
            Y: \(event.scrollingDeltaY) | \
            Precise: \(event.hasPreciseScrollingDeltas)
            """
        )
    }

    // MARK: - Mouse

    override func mouseDown(with event: NSEvent) {
        window?.makeFirstResponder(self)
        logger?.log("LEFT MOUSE DOWN")
    }

    override func mouseUp(with event: NSEvent) {
        logger?.log("LEFT MOUSE UP")
    }

    override func rightMouseDown(with event: NSEvent) {
        logger?.log("RIGHT MOUSE DOWN")
    }

    override func rightMouseUp(with event: NSEvent) {
        logger?.log("RIGHT MOUSE UP")
    }

    override func mouseMoved(with event: NSEvent) {
        logger?.log(
            "MOUSE MOVED | \(event.locationInWindow)"
        )
    }

    override func mouseDragged(with event: NSEvent) {
        logger?.log(
            "MOUSE DRAGGED | \(event.locationInWindow)"
        )
    }

    // MARK: - Pressure

    override func pressureChange(with event: NSEvent) {
        logger?.log(
            "PRESSURE | \(event.pressure)"
        )
    }
}
