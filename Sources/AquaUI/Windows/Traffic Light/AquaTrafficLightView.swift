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
            baseColor
            .shadow(.inner(color: .black, radius: 0.3))
          )
        
        Circle()
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
        
        
        Ellipse()
          .fill(
            .linearGradient(stops: [.init(color: .white, location: 0), .init(color: .clear, location: 0.9)], startPoint: .top, endPoint: .bottom)
          )
          .frame(width: reader.size.width/2, height: reader.size.height/3)
          .offset(y: -reader.size.height/5)
          .opacity(0.8)

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
          .opacity(0.5)
        
        Circle()
          .fill(
            .radialGradient(
              colors: [.white, .clear],
              center: .init(x: 0.5, y: 0.8),
              startRadius: 0,
              endRadius: reader.size.width / 2)
          )
          .opacity(0.55)
      }
    }
    .padding(1)
  }
}

#Preview {
  let size = NSWindow.standardWindowButton(.closeButton, for: .closable)!.frame.size
  let width = size.width
  let height = size.height
  HStack {
    AquaTrafficLightView(viewModel: .init(type: .red)).frame(width: width, height: height)
    AquaTrafficLightView(viewModel: .init(type: .amber)).frame(width: width, height: height)
    AquaTrafficLightView(viewModel: .init(type: .green)).frame(width: width, height: height)
  }.scaleEffect(CGSize(width: 2, height: 2)).padding(40)
}
