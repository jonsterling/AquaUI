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
    ZStack {
      AquaToolbarLozengeBackgroundView(isPressed: configuration.isPressed, isOn: isOn)
      Capsule()
        .stroke(
          .linearGradient(stops: [
            .init(color: .black.opacity(0.6), location: 0.0),
            .init(color: .black.opacity(0.3), location: 0.7)
          ], startPoint: .top, endPoint: .bottom),
          lineWidth: 1.5
        )
    }
    .clipShape(Capsule())
  }
}

#Preview {
  Button("") {}
    .buttonStyle(AquaToolbarLozengeButtonStyle(isOn: false))
    .frame(width: 20, height: 10)
    .padding()
}
