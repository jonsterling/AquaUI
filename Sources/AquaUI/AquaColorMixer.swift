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

public
struct AquaColorMixer {
  public let environment: EnvironmentValues
  
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
}
