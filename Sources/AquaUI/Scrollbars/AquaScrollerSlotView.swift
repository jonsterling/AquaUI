//
//  AquaScrollerSlotView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import SwiftUI

struct AquaScrollerSlotView: View {
  static let topPadding: CGFloat = 7.0
  static let bottomPadding: CGFloat = 10.0

  var body: some View {
    let rimPrimaryColor: Color = .white
    let rimHighlightColor: Color = .init(.displayP3, red: 0.85, green: 0.85, blue: 0.85)
    
    let rimGradient = Gradient(colors: [
      rimPrimaryColor,
      rimHighlightColor,
      rimPrimaryColor
    ])
    
    let bedColor: Color = .white
    
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
            .shadow(.inner(color: .gray, radius: 3, y: 0))
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
