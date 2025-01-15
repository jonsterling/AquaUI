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
    
    let brightness =
    if isActive {
      if environment.colorScheme == .dark {
        -0.2
      } else {
        0.05
      }
    } else {
      if environment.colorScheme == .dark {
        0.05
      } else {
        0.15
      }
    }
    
    let saturation =
    if environment.colorScheme == .dark {
      0.8
    } else {
      0.9
    }
    
    ZStack {
      ZStack {
        if isActive {
          AquaScrollerWave(scrollOffset: $scrollOffset)
        }
        
        Rectangle()
          .fill(.linearGradient(backgroundGradient, startPoint: .leading, endPoint: .trailing))
          .opacity(0.9)
        
        
        RoundedRectangle(cornerRadius: 5)
          .fill(.linearGradient(shineGradient, startPoint: .leading, endPoint: .trailing))
          .offset(x: -6)
          .frame(width: 7)
          .padding(.vertical, 3)
          .opacity(0.7)
        
      }
      .saturation(saturation)
      .brightness(brightness)
      .grayscale(isActive ? 0 : 1.0)
    }
  }
}

#Preview {
  AquaScrollerKnobBackground(scrollOffset: .constant(0), isActive: .constant(true))
    .frame(width: 15, height: 100)
    .padding()
}
