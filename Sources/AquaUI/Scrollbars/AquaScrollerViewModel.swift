//
//  AquaScrollerViewModel.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 26/12/2024.
//

import Foundation

class AquaScrollerViewModel : ObservableObject {
  @Published var scrollOffset: CGFloat = 0.0
  @Published var isActive: Bool = true
}
