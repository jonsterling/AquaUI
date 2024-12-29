//
//  AquaScrollerKnobBackground.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import SwiftUI

struct AquaScrollerKnobBackground: View {
  @Environment(\.self) var environment
  @Binding var scrollOffset: CGFloat
  @Binding var isActive: Bool
  
  var body: some View {
    let colorMixer = AquaColorMixer(environment: environment)
      
    let shineGradient = Gradient(colors: [
      colorMixer.baseColor.mix(with: .white, by: 0.9),
      colorMixer.baseColor.mix(with: .white, by: 0.7),
    ])
        
    let backgroundGradient = Gradient(colors: [
      colorMixer.darkColor,
      colorMixer.mediumColor,
      colorMixer.lightColor
    ])
    
    ZStack {
      AquaScrollerWave(scrollOffset: $scrollOffset)
      
      Capsule()
        .fill(.linearGradient(backgroundGradient, startPoint: .leading, endPoint: .trailing))
        .opacity(0.9)
      
      RoundedRectangle(cornerRadius: 5)
        .fill(.linearGradient(shineGradient, startPoint: .leading, endPoint: .trailing))
        .offset(x: -6)
        .frame(width: 7)
        .padding(.vertical, 3)
        .opacity(0.7)
      
      Capsule()
        .stroke(.black, lineWidth: 2)
        .opacity(0.5)
    }
    .saturation(0.9)
    .brightness(isActive ? 0.05 : 0.15)
    .grayscale(isActive ? 0 : 1.0)
    .clipShape(Capsule())
  }
}

#Preview {
  AquaScrollerKnobBackground(scrollOffset: .constant(0), isActive: .constant(true))
    .frame(width: 15, height: 100)
    .padding()
}
