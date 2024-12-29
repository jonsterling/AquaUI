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
    let outlineGradient = Gradient(stops: [
      .init(color: Color(.sRGB, red: 0, green: 0.11, blue: 0.35), location: 0.45),
      .init(color: Color(.sRGB, red: 0.36, green: 0.36, blue: 0.36), location: 0.55)
    ])
    
    ZStack {
      AquaScrollerKnobBackground(scrollOffset: $viewModel.scrollOffset, isActive: $viewModel.isActive)
      Capsule()
        .stroke(LinearGradient(gradient: outlineGradient, startPoint: .leading, endPoint: .trailing))
    }
    .clipShape(Capsule())
    .shadow(color: Color(.sRGB, red: 0.71, green: 0.71, blue: 0.71), radius: 0.5, x: 0, y: 1)
    .padding(.top, AquaScrollerSlotView.topPadding - 1)
    .padding(.bottom, AquaScrollerSlotView.bottomPadding-2)
  }
  
}

#Preview {
  AquaScrollerKnobView(viewModel: AquaScrollerViewModel())
    .frame(width: 15, height: 100)
    .padding()
}
