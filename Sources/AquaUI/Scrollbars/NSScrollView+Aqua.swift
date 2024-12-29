//
//  NSScrollView+Aqua.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import Cocoa

public extension NSScrollView {
  /// Produce a scroll view with an Aqua-styled (vertical) scroller. **TODO**: style the horizontal scroller.
  static func aquaScrollView() -> NSScrollView {
    let scrollView = NSScrollView()
    scrollView.verticalScroller = AquaScroller()
    return scrollView
  }
}
