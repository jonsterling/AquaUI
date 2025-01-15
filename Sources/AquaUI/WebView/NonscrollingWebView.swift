//
//  NonscrollingWebView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 15/01/2025.
//

import Cocoa
import WebKit

class NonscrollingWebView : WKWebView {
  override func scrollWheel(with theEvent: NSEvent) {
    nextResponder?.scrollWheel(with: theEvent)
    return
  }
}
