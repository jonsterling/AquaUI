//
//  FirstMouseHostingView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 30/12/2024.
//

import SwiftUI

class FirstMouseHostingView<Content: View>: NSHostingView<Content> {
  override public func acceptsFirstMouse(for event: NSEvent?) -> Bool {
    true
  }
}

