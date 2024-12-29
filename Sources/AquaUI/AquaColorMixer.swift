//  AquaColorMixer.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 29/12/2024.
//

import SwiftUI

extension Color.Resolved {
  var isGrayscale: Bool {
    linearRed == linearGreen && linearGreen == linearBlue
  }
}

/// `AquaColorMixer` provides colors to be used in Aqua control gradients, taking account of the ambient accent color. When the accent color is gray, it produces graphite-tinted colors.
public struct AquaColorMixer {
  public let environment: EnvironmentValues
  
  /// An environment is required in order to introspect on the accent color.
  public init(environment: EnvironmentValues) {
    self.environment = environment
  }
  
  var resolvedAccentColor: Color.Resolved {
    Color.accentColor.resolve(in: environment)
  }
  
  var mixColor: Color {
    if resolvedAccentColor.isGrayscale { Color.blue } else { Color.green }
  }
  
  public var baseColor: Color {
    Color.accentColor.mix(with: mixColor, by: 0.2)
  }
  
  public var darkColor: Color {
    baseColor.mix(with: .black, by: 0.2, in: .perceptual)
  }
  
  public var mediumColor: Color {
    baseColor.mix(with: .white, by: 0.2, in: .perceptual)
  }
  
  public var lightColor: Color {
    baseColor.mix(with: .white, by: 0.8, in: .perceptual)
  }
  
  public var graphiteColor: Color {
    .gray.mix(with: .blue, by: 0.2).mix(with: .white, by: 0.3)
  }
  
  public var redTrafficLightColor: Color {
    if resolvedAccentColor.isGrayscale { graphiteColor } else {
      Color(red: 0.93, green: 0.42, blue: 0.37)
    }
  }
  
  public var amberTrafficLightColor: Color {
    if resolvedAccentColor.isGrayscale { graphiteColor } else {
      Color(red: 0.96, green: 0.75, blue: 0.31)
    }
  }
  
  public var greenTrafficLightColor: Color {
    if resolvedAccentColor.isGrayscale { graphiteColor } else {
      Color(red: 0.39, green: 0.78, blue: 0.34)
    }
  }
  
  public var inactiveTrafficLightColor: Color {
    Color(red: 0.7, green: 0.7, blue: 0.72)
  }
  
  // Thanks to https://github.com/thompsonate/Lickable-Button/
  public var buttonBackgroundGradient: Gradient {
    Gradient(stops: [
      .init(color: Color(.displayP3, red: 0.8, green: 0.8, blue: 0.8), location: 0),
      .init(color: Color(.displayP3, red: 0.98, green: 0.98, blue: 0.98), location: 0.75),
      .init(color: Color.white, location: 0.8),
    ])
  }
  
  public var pressedButtonBackgroundGradient: Gradient {
    Gradient(stops: [
      .init(color: Color(.displayP3, red: 0.33, green: 0.56, blue: 0.78), location: 0),
      .init(color: Color(.displayP3, red: 0.44, green: 0.62, blue: 0.82), location: 0.5),
      .init(color: Color(.displayP3, red: 0.75, green: 0.88, blue: 0.96), location: 1),
    ])
  }
  
  public var toolbarLozengeButtonBackgroundGradient: Gradient {
    buttonBackgroundGradient
  }
  
  public var pressedToolbarLozengeButtonBackgroundGradient: Gradient {
    Gradient(stops: [
      .init(color: Color(.displayP3, red: 0.7, green: 0.7, blue: 0.7), location: 0),
      .init(color: Color(.displayP3, red: 0.88, green: 0.88, blue: 0.88), location: 0.75),
      .init(color: Color(.displayP3, red: 0.9, green: 0.9, blue: 0.9), location: 8),
    ])
  }
  
}
