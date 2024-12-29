//
//  AquaToolbarLozengeButtonStyle.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 29/12/2024.
//

import SwiftUI

public struct AquaToolbarLozengeButtonStyle: ButtonStyle {
  public var isOn: Bool = false
  
  public init(isOn: Bool) {
    self.isOn = isOn
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    let outlineGradient = Gradient(colors: [Color(red: 0.36, green: 0.36, blue: 0.36)])
    ZStack {
      AquaToolbarLozengeBackgroundView(isPressed: configuration.isPressed, isOn: isOn)
      Capsule()
        .stroke(LinearGradient(
          gradient: outlineGradient,
          startPoint: .top,
          endPoint: .bottom))
        .opacity(0.8)
    }
    .clipShape(Capsule())
  }
}


