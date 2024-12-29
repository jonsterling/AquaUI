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
  
  var body: some View {
    GeometryReader { reader in
      ZStack(alignment: .center) {
        Circle()
          .fill(
            .linearGradient(stops: [
              .init(color: .init(red: 0.92, green: 0.83, blue: 0.82), location: 0.0),
              .init(color: baseColor, location: 0.3),
            ], startPoint: .top, endPoint: .bottom)
            .shadow(.inner(color: .black, radius: 0.3))
          )
          .stroke(
            .linearGradient(stops: [
              .init(color: .black.opacity(0.6), location: 0.0),
              .init(color: .black.opacity(0.2), location: 0.7)
            ], startPoint: .top, endPoint: .bottom),
            lineWidth: 1
          )
        
        if viewModel.isHovered {
          let width = reader.size.width / 2
          Image(systemName: systemSymbolName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: nil, alignment: .center)
            .bold()
            .foregroundStyle(.black.opacity(0.6))
        }
        
        if viewModel.isHighlighted {
          Circle().fill(.black.opacity(0.2))
        }
        
        Circle()
          .fill(
            .radialGradient(
              colors: [.white, .clear],
              center: .bottom,
              startRadius: reader.size.width / 5,
              endRadius: reader.size.width / 2)
          )
          .opacity(0.3)
          .clipShape(Circle())
      }
    }
    .padding(1)
    .offset(y: 1)
  }
}

#Preview {
  HStack {
    AquaTrafficLightView(viewModel: .init(type: .red)).frame(width: 26, height: 26)
    AquaTrafficLightView(viewModel: .init(type: .amber)).frame(width: 26, height: 26)
    AquaTrafficLightView(viewModel: .init(type: .green)).frame(width: 26, height: 26)
  }
}
