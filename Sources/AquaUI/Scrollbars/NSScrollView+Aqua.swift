//
//  NSScrollView+Aqua.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import Cocoa

public extension NSScrollView {
  func aquify() {
    verticalScroller = AquaScroller()
  }
  
  static func aquaScrollView() -> NSScrollView {
    let scrollView = NSScrollView()
    scrollView.aquify()
    return scrollView
  }
}
