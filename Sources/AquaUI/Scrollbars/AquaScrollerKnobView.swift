//
//  AquaScrollerKnobView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import SwiftUI

struct AquaScrollerKnobView: View {
  @ObservedObject var viewModel: AquaScrollerViewModel

  var body: some View {    
    AquaScrollerKnobBackground(scrollOffset: $viewModel.scrollOffset, isActive: $viewModel.isActive)
    .clipShape(Capsule())
    .overlay(Capsule().stroke(.black.opacity(0.3)))
    .shadow(color: .black.opacity(0.3), radius: 0.5, x: 0, y: 1)
    .padding(.top, AquaScrollerSlotView.topPadding - 1)
    .padding(.bottom, AquaScrollerSlotView.bottomPadding - 2)
    .padding([.trailing, .leading], 0.5)
  }
}

#Preview {
  AquaScrollerKnobView(viewModel: AquaScrollerViewModel())
    .frame(width: 15, height: 100)
    .padding()
}
