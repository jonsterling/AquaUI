//
//  AquaTrafficLightButton.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import Cocoa
import SwiftUI

class AquaTrafficLightButton: NSButton {
  let viewModel = AquaTrafficLightViewModel(type: .red)
  
  lazy var buttonView: AquaTrafficLightView = {
    AquaTrafficLightView(viewModel: viewModel)
  }()
  
  private func configure() {
    title = ""
    isBordered = false
    setButtonType(.pushOnPushOff)
    
    let hostingView = NSHostingView(rootView: self.buttonView)
    hostingView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(hostingView)
    
    var trackingAreaOptions: NSTrackingArea.Options = .activeInActiveApp
    trackingAreaOptions.insert(.mouseEnteredAndExited)
    trackingAreaOptions.insert(.assumeInside)
    trackingAreaOptions.insert(.inVisibleRect)
    
    let trackingArea = NSTrackingArea(rect: .zero, options: trackingAreaOptions, owner: self)
    addTrackingArea(trackingArea)
    
    NSLayoutConstraint.activate([
      hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
      hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
      hostingView.topAnchor.constraint(equalTo: topAnchor),
      hostingView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configure()
  }
  
  @objc
  func setDocumentEdited(_ edited: Bool) { }
  
  override func draw(_ dirtyRect: NSRect) {
    viewModel.isActive = if let window = window { window.isKeyWindow } else { false }
    viewModel.isHighlighted = isHighlighted
  }
  
  override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
    return true
  }
  
  override func mouseEntered(with event: NSEvent) {
    super.mouseEntered(with: event)
    NSApp.sendAction(#selector(AquaWindow.hoverTrafficLights(_:)), to: nil, from: self)
  }
  
  override func mouseExited(with event: NSEvent) {
    super.mouseExited(with: event)
    NSApp.sendAction(#selector(AquaWindow.unhoverTrafficLights(_:)), to: nil, from: self)
  }
}
