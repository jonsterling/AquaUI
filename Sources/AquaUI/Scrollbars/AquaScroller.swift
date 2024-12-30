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
    NSHostingView(rootView: AquaScrollerSlotView())
  }()
  
  lazy var knobHostingView: NSHostingView<AquaScrollerKnobView> = {
    NSHostingView(rootView: AquaScrollerKnobView(viewModel: viewModel))
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
  
  public override func drawKnob() {
    let rect = rect(for: .knob)
    viewModel.scrollOffset = rect.origin.y
    viewModel.isActive = if let window = window { window.isKeyWindow } else { false }
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
