//
//  NSWindow+AquaDrawer.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 20/04/2025.
//

import AppKit

extension NSWindow {
  static public func aquaDrawer(contentViewController: NSViewController) -> Self {
    let drawer = Self(contentViewController: contentViewController)
    drawer.styleMask = []
    drawer.backgroundColor = .clear
    drawer.hasShadow = true
    if let drawerContentView = drawer.contentView {
      drawerContentView.wantsLayer = true
      if let layer = drawerContentView.layer {
        layer.borderColor = CGColor(gray: 0.8, alpha: 1.0)
        layer.backgroundColor = NSColor.white.cgColor
        layer.borderWidth = 4
        layer.cornerRadius = 5
      }
    }
    
    return drawer
  }
}
