//
//  AquaToolbarLozengeBackgroundView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 29/12/2024.
//

import SwiftUI

struct AquaToolbarLozengeBackgroundView: View {
  @Environment(\.self) var environment
  var isPressed: Bool
  var isOn: Bool
  
  var body: some View {
    let colorMixer = AquaColorMixer(environment: environment)
    
    let shineGradient = Gradient(colors: [
      .white,
      Color.white.opacity(0.5)
    ])
    
    let backgroundGradient = if isPressed {
      colorMixer.pressedToolbarLozengeButtonBackgroundGradient
    } else {
      colorMixer.toolbarLozengeButtonBackgroundGradient
    }
    
    ZStack {
      Capsule()
        .fill(
          LinearGradient(
            gradient: backgroundGradient,
            startPoint: .top,
            endPoint: .bottom))
      
      if isOn {
        Capsule().fill(.black.opacity(0.1))
      }
      
      RoundedRectangle(cornerRadius: 5)
        .fill(LinearGradient(
          gradient: shineGradient,
          startPoint: .top,
          endPoint: .bottom))
        .offset(y: -6)
        .frame(height: 7)
        .padding(.horizontal, 3)
    }.clipShape(Capsule())
  }
}

#Preview {
  AquaToolbarLozengeBackgroundView(isPressed: false, isOn: false)
    .frame(width: 20, height: 10)
    .padding()

}
