//
//  AquaUnifiedTitlebarBackgroundView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 18/04/2025.
//

import Cocoa

public class AquaUnifiedTitlebarBackgroundView: NSView {
  public override func draw(_ dirtyRect: NSRect) {
    let gradientStartingColor = NSColor(displayP3Red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
    let gradientEndingColor = NSColor(displayP3Red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
    let separatorColor = NSColor(displayP3Red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0)
    
    let titlebarGradient = NSGradient(starting: gradientStartingColor, ending: gradientEndingColor)
    
    let titlebarSeparatorPath = {
      let path = NSBezierPath()
      let y = bounds.minY + 1
      path.move(to: NSPoint(x: 0.0, y: y))
      path.line(to: NSPoint(x: bounds.maxX, y: y))
      return path
    }()
    
    titlebarGradient?.draw(in: bounds, angle: 270.0)
    
    separatorColor.set()
    titlebarSeparatorPath.stroke()
  }
  
  public func defaultLayoutConstraints(within view: NSView) -> [NSLayoutConstraint] {
    return [
      leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      topAnchor.constraint(equalTo: view.topAnchor)
    ]
  }
}
