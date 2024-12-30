//
//  AquaScrollerWave.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import SwiftUI

struct AquaScrollerWave: View {
  @Binding var scrollOffset: CGFloat
  private let waveGradient = Gradient(colors: [.white, .black, .white])
  
  var body: some View {
    Canvas { context, size in
      let startPoint = CGPoint(x: 0, y: -scrollOffset)
      let endPoint = startPoint.applying(.init(translationX: 0, y: 15))
      let shading = GraphicsContext.Shading.linearGradient(waveGradient, startPoint: startPoint, endPoint: endPoint, options: .repeat)
      context.fill(Path(CGRect(origin: .zero, size: size)), with: shading)
    }
  }
}


#Preview {
  AquaScrollerWave(scrollOffset: .constant(0))
}
