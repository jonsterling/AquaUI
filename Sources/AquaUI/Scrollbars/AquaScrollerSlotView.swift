//
//  AquaScrollerSlotView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import SwiftUI

struct AquaScrollerSlotView: View {
  @Environment(\.colorScheme) var colorScheme
  
  static let topPadding: CGFloat = 7.0
  static let bottomPadding: CGFloat = 10.0
  
  var body: some View {
    let rimPrimaryColor: Color =
    if colorScheme == .dark { Color(.windowBackgroundColor) } else { .white}
    let rimHighlightColor: Color =
    if colorScheme == .dark { .black.mix(with: .white, by: 0.35) } else {
      .init(.displayP3, red: 0.85, green: 0.85, blue: 0.85)
    }
    
    let rimGradient = Gradient(colors: [
      rimPrimaryColor,
      rimHighlightColor,
      rimPrimaryColor
    ])
    
    let bedColor: Color = if colorScheme == .dark { .black.mix(with: .white, by: 0.35) } else { .white }
    
    let innerShadowColor: Color = if colorScheme == .dark { .black.opacity(0.7) } else { .gray }
    
    ZStack {
      Rectangle()
        .fill(
          LinearGradient(
            gradient: rimGradient,
            startPoint: .leading,
            endPoint: .trailing)
        )
        .stroke(.quaternary)
      
      ZStack {
        Capsule()
          .fill(
            .shadow(.inner(color: innerShadowColor, radius: 3, y: 0))
          )
          .foregroundStyle(bedColor)
      }
      .padding(.top, Self.topPadding)
      .padding(.bottom, Self.bottomPadding)
    }
  }
}

#Preview {
  AquaScrollerSlotView().frame(width: 15, height: 100).padding()
}
