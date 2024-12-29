//
//  AquaWindow.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import Cocoa

/// A subclass of `NSWindow` with Aqua-styled traffic light control buttons.
open class AquaWindow : NSWindow {
  private func trafficLightButtons() -> [AquaTrafficLightButton] {
    let types: [ButtonType] = [.closeButton, .miniaturizeButton, .zoomButton]
    return types.compactMap { b in
      standardWindowButton(b) as? AquaTrafficLightButton
    }
  }
  
  @objc func hoverTrafficLights(_ sender: AquaTrafficLightButton) {
    for button in trafficLightButtons() {
      button.viewModel.isHovered = true
    }
  }
  
  @objc func unhoverTrafficLights(_ sender: AquaTrafficLightButton) {
    for button in trafficLightButtons() {
      button.viewModel.isHovered = false
    }
  }

  public override static func standardWindowButton(_ b: NSWindow.ButtonType, for styleMask: NSWindow.StyleMask) -> NSButton? {
    guard let original = super.standardWindowButton(b, for: styleMask) else { return nil }
    let frame = original.frame
    
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
