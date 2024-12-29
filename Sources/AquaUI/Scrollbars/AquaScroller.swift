//
//  AquaScroller.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import Cocoa
import SwiftUI

class AquaScroller : NSScroller {
  @ObservedObject var viewModel = AquaScrollerViewModel()
  
  var slotHostingView: NSHostingView<AquaScrollerSlotView>?
  var knobHostingView: NSHostingView<AquaScrollerKnobView>?
  var observation: NSKeyValueObservation?
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    slotHostingView = NSHostingView(rootView: AquaScrollerSlotView())
    knobHostingView = NSHostingView(rootView: AquaScrollerKnobView(viewModel: viewModel))
    self.addSubview(slotHostingView!)
    self.addSubview(knobHostingView!)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func drawKnob() {
    let rect = rect(for: .knob)
    viewModel.scrollOffset = rect.origin.y
    viewModel.isActive = if let window = window { window.isKeyWindow } else { false }
    knobHostingView?.frame = rect
  }
  
  override func drawKnobSlot(in slotRect: NSRect, highlight flag: Bool) {
    var rect = slotRect
    rect.size.height += 1
    slotHostingView?.frame = rect
  }
  
  override func checkSpaceForParts() {
    super.checkSpaceForParts()
    knobHostingView?.isHidden = usableParts != .allScrollerParts
  }
}
