//
//  AquaTrafficLightView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import SwiftUI

struct AquaTrafficLightView: View {
  @Environment(\.self) var environment
  @ObservedObject var viewModel: AquaTrafficLightViewModel
  
  var baseColor: Color {
    let colorMixer = AquaColorMixer(environment: environment)
    return if viewModel.isActive {
      switch viewModel.type {
      case .red: colorMixer.redTrafficLightColor
      case .amber: colorMixer.amberTrafficLightColor
      case .green: colorMixer.greenTrafficLightColor
      }
    } else {
      colorMixer.inactiveTrafficLightColor
    }
  }
  
  var systemSymbolName: String {
    return switch viewModel.type {
    case .red: "xmark"
    case .amber: "minus"
    case .green: "plus"
    }
  }
  
  var baseCircle: some View {
    Circle()
      .fill(
        baseColor
          .shadow(.inner(color: .black, radius: 0.3))
      )
  }
  
  var innerShadow: some View {
    Circle()
      .stroke(
        .linearGradient(stops: [
          .init(color: .black.opacity(0.8), location: 0.0),
          .init(color: .black.opacity(0.2), location: 0.7)
        ], startPoint: .top, endPoint: .bottom),
        lineWidth: 1
      )
  }
  
  var glyph: some View {
    Image(systemName: systemSymbolName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .fontWeight(.black)
      .foregroundStyle(.black.opacity(0.7))
  }

  
  var body: some View {
    GeometryReader { reader in
      ZStack(alignment: .center) {
        baseCircle
        innerShadow
        
        if viewModel.isHovered {
          glyph
            .frame(
              width: reader.size.width * 0.5,
              height: nil,
              alignment: .center)
        }
        
        
        if viewModel.isHighlighted {
          Circle().fill(.black.opacity(0.2))
        }
        
        
        Circle()
          .fill(
            .linearGradient(
              stops: [
                .init(color: .white, location: 0),
                .init(color: .white, location: 0.6),
                .init(color: .white.opacity(0.55),location: 0.8),
                .init(color: .clear,location: 0.96)
              ],
              startPoint: .top, endPoint: .bottom)
          )
          .offset(y: -reader.size.height/1.6)
          .clipShape(Circle())
          .padding(.all, 1.0)
        
        Circle()
          .fill(
            .ellipticalGradient(stops: [.init(color: .clear, location: 0), .init(color: .black, location: 0.2)], startRadiusFraction: 0.3, endRadiusFraction: 1)
          )
          .mask(
            LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom)
          )
          .mask(
            LinearGradient(colors: [.black, .clear, .black], startPoint: .leading, endPoint: .trailing)
          )
          .opacity(0.7)
        
        Circle()
          .fill(
            .radialGradient(
              colors: [.white, .clear],
              center: .init(x: 0.5, y: 0.8),
              startRadius: 2,
              endRadius: reader.size.width / 2)
          )
          .opacity(0.4)
      }
    }
    .padding(1)
  }
}

#Preview {
  let width = 20.0
  let height = 20.0
  HStack {
    AquaTrafficLightView(viewModel: .init(type: .red)).frame(width: width, height: height)
    AquaTrafficLightView(viewModel: .init(type: .amber)).frame(width: width, height: height)
    AquaTrafficLightView(viewModel: .init(type: .green)).frame(width: width, height: height)
  }.padding(40)
}
