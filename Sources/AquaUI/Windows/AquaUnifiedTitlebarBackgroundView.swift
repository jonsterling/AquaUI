//
//  AquaUnifiedTitlebarBackgroundView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 18/04/2025.
//

import Cocoa
import SwiftUICore

public class AquaUnifiedTitlebarBackgroundView: NSView {
  open var gradientStartingColor: NSColor {
    if NSApp.effectiveAppearance.colorScheme == .light {
      NSColor(white: 236/255, alpha: 1.0)
    } else {
      NSColor(white: 70/255, alpha: 1.0)
    }
  }
  
  open var gradientEndingColor: NSColor {
    if NSApp.effectiveAppearance.colorScheme == .light {
      NSColor(white: 216/255, alpha: 1.0)
    } else {
      NSColor(white: 50/255, alpha: 1.0)
    }
  }
  
  open var gradient: NSGradient {
    NSGradient(starting: gradientStartingColor, ending: gradientEndingColor)!
  }
  
  public override func draw(_ dirtyRect: NSRect) {
    let titlebarSeparatorPath = {
      let path = NSBezierPath()
      let y = bounds.minY + 1
      path.move(to: NSPoint(x: 0.0, y: y))
      path.line(to: NSPoint(x: bounds.maxX, y: y))
      return path
    }()
    
    gradient.draw(in: bounds, angle: 270.0)
    
    NSColor.separatorColor.set()
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
