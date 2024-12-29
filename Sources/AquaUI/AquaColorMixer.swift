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
}
