//
//  NSAppearance+ColorScheme.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 20/04/2025.
//

import AppKit
import SwiftUICore

extension NSAppearance {
  @MainActor
  var colorScheme: ColorScheme {
    if NSApp.effectiveAppearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua { .dark } else { .light }
  }
}
