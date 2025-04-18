//
//  AquaWindow.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import Cocoa

/// A subclass of `NSWindow` with Aqua-styled traffic light control buttons.
open class AquaWindow : NSWindow {
  private var toolbarObservation: NSKeyValueObservation?
  private let toolbarLozengeController = AquaToolbarLozengeViewController()
  
  /// When `true`, the toolbar toggle button will appear in the right-hand corner of the window. This property supersedes the old `NSWindow.showsToolbarButton` property to restore the pre-10.7 toolbar button.
  @objc public var showsAquaToolbarButton: Bool = false {
    didSet { updateToolbarLozengeVisibility() }
  }
  
  override open var toolbarStyle: NSWindow.ToolbarStyle {
    didSet { toolbarLozengeController.windowToolbarStyle = toolbarStyle }
  }
  
  @MainActor
  private func updateToolbarLozengeVisibility() {
    let shouldBeVisible = showsAquaToolbarButton && toolbar != nil
    let existingIndex = titlebarAccessoryViewControllers.firstIndex(of: toolbarLozengeController)
    if shouldBeVisible {
      if existingIndex == nil {
        addTitlebarAccessoryViewController(toolbarLozengeController)
      }
    } else if let existingIndex {
      removeTitlebarAccessoryViewController(at: existingIndex)
    }
  }
  
  public override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
    super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)

    toolbarObservation = observe(\.toolbar?.isVisible, options: [.initial, .new]) { window, observedChange in
      Task { @MainActor in
        self.updateToolbarLozengeVisibility()
        if let toolbarVisible = observedChange.newValue, let toolbarVisible {
          self.toolbarLozengeController.toolbarShown = toolbarVisible
        }
      }
    }
  }
  
  private var trafficLightButtons: [AquaTrafficLightButton] {
    let types: [ButtonType] = [.closeButton, .miniaturizeButton, .zoomButton]
    return types.compactMap { b in
      standardWindowButton(b) as? AquaTrafficLightButton
    }
  }
  
  @objc func hoverTrafficLights(_ sender: AquaTrafficLightButton) {
    for button in trafficLightButtons {
      button.viewModel.isHovered = true
    }
  }
  
  @objc func unhoverTrafficLights(_ sender: AquaTrafficLightButton) {
    for button in trafficLightButtons {
      button.viewModel.isHovered = false
    }
  }
  
  public override static func standardWindowButton(_ b: NSWindow.ButtonType, for styleMask: NSWindow.StyleMask) -> NSButton? {
    guard let original = super.standardWindowButton(b, for: styleMask) else { return nil }
    var frame = original.frame
    frame.size.width = 15
    frame.size.height = 16
    
    switch b {
    case .closeButton:
      let button = AquaTrafficLightButton(frame: frame)
      button.viewModel.type = .red
      button.action = #selector(close)
      return button
    case .miniaturizeButton:
      let button = AquaTrafficLightButton(frame: frame)
      button.viewModel.type = .amber
      button.action = #selector(miniaturize(_:))
      return button
    case .zoomButton:
      let button = AquaTrafficLightButton(frame: frame)
      button.viewModel.type = .green
      button.action = #selector(zoom(_:))
      return button
    default:
      return original
    }
  }
}

