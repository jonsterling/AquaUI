//
//  AquaDrawerController.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 20/04/2025.
//

import AppKit
import Combine

open class AquaDrawerController: NSWindowController, NSWindowDelegate {
  @objc public dynamic var drawerShown: Bool = true
  open var frameForDrawer: NSRect? {
    guard let window, let parent = window.parent else { return nil }
    let width = if drawerShown { 200.0 } else { 0.0 }
    let x = -width + 10
    let frame = NSRect(x: x, y: 0, width: width, height: parent.frame.height).insetBy(dx: 0, dy: 10)
    return parent.convertToScreen(frame)
  }
  
  var drawerLayoutObserver: Combine.Cancellable?
  
  public override init(window: NSWindow?) {
    super.init(window: window)
    
    let parentFrameObserver = publisher(for: \.window?.parent?.frame).map { _ in false }
    let drawerShownObserver = publisher(for: \.drawerShown).removeDuplicates().map { _ in true }
    
    drawerLayoutObserver =
    parentFrameObserver
      .merge(with: drawerShownObserver)
      .sink { [weak self] shouldAnimate in
        self?.layoutDrawer(animate: shouldAnimate)
      }
    
    windowDidLoad()
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func layoutDrawer(animate: Bool) {
    if let frameForDrawer {
      window?.setFrame(frameForDrawer, display: true, animate: animate)
    }
  }
}
