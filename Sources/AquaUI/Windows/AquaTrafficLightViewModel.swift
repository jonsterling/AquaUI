//
//  AquaTrafficLightViewModel.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 27/12/2024.
//

import SwiftUI

enum TrafficLightType {
  case red
  case amber
  case green
}

class AquaTrafficLightViewModel: ObservableObject {
  @Published var type: TrafficLightType
  @Published var isHighlighted: Bool = false
  @Published var isHovered: Bool = false
  @Published var isActive: Bool = true
  
  init(type: TrafficLightType) {
    self.type = type
  }
}

