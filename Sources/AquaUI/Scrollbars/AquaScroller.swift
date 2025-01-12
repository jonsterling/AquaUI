//
//  AquaScroller.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import Cocoa
import SwiftUI

public class AquaScroller : NSScroller {
  @ObservedObject var viewModel = AquaScrollerViewModel()
  
  lazy var slotHostingView: NSHostingView<AquaScrollerSlotView> = {
    FirstMouseHostingView(rootView: AquaScrollerSlotView())
  }()
  
  lazy var knobHostingView: NSHostingView<AquaScrollerKnobView> = {
    FirstMouseHostingView(rootView: AquaScrollerKnobView(viewModel: viewModel))
  }()
  
  private func configureSubviews() {
    addSubview(slotHostingView)
    addSubview(knobHostingView)
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    configureSubviews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configureSubviews()
  }
  
  open var minimumKnobHeight: CGFloat { 40 }
  
  public override func rect(for partCode: NSScroller.Part) -> NSRect {
    var rect = super.rect(for: partCode)
    if partCode == .knob {
      // TODO: this code does succeed to make the knob have a minimum height, but the tracking is kind of messed up. If the user grabs a knob that has been forced to a minimum size, it jumps.
      let knobHeight = max(rect.height, minimumKnobHeight)
      rect.size.height = knobHeight
      rect.origin.y = (bounds.height - knobHeight) * CGFloat(floatValue)
    }
    return rect
  }
  
  public override func drawKnob() {
    var rect = rect(for: .knob)

    viewModel.scrollOffset = rect.origin.y
    viewModel.isActive = if let window { window.isKeyWindow } else { false }
    knobHostingView.frame = rect
  }
  
  public override func drawKnobSlot(in slotRect: NSRect, highlight flag: Bool) {
    var rect = slotRect
    rect.size.height += 1
    slotHostingView.frame = rect
  }
  
  public override func checkSpaceForParts() {
    super.checkSpaceForParts()
    knobHostingView.isHidden = usableParts != .allScrollerParts
  }
}
