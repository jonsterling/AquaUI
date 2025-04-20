//
//  NSWindow+AquaDrawer.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 20/04/2025.
//

import AppKit
import Combine

open class AquaDrawer: NSWindow {
  var observation: Cancellable?
  
  open override var contentView: NSView? {
    didSet { updateAppearance() }
  }
  
  open override var styleMask: NSWindow.StyleMask {
    set {}
    get { [] }
  }
  
  open override var backgroundColor: NSColor! {
    set {}
    get { .clear }
  }
  
  open override var hasShadow: Bool {
    set {}
    get { true }
  }
  
  override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
    super.init(contentRect: contentRect, styleMask: [], backing: backingStoreType, defer: flag)
    observation = NSApp.publisher(for: \.effectiveAppearance).sink { _ in
      self.updateAppearance()
    }
  }
  
  func updateAppearance() {
    if let contentView {
      contentView.wantsLayer = true
      if let layer = contentView.layer {
        layer.borderColor = if NSApp.effectiveAppearance.colorScheme == .light {
          NSColor(white: 0.9, alpha: 1.0).cgColor
        } else {
          NSColor(white: 0.2, alpha: 1.0).cgColor
        }
        layer.backgroundColor = NSColor.windowBackgroundColor.cgColor
        layer.borderWidth = 5
        layer.cornerRadius = 6
      }
    }
  }
}

