//
//  AquaToolbarLozengeView.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 29/12/2024.
//

import SwiftUI

public class AquaToolbarLozengeViewModel: ObservableObject {
  @Published public var isOn: Bool = false
  public init() {}
}

public struct AquaToolbarLozengeView: View {
  @StateObject var viewModel: AquaToolbarLozengeViewModel = AquaToolbarLozengeViewModel()
  
  public var body: some View {
    let buttonStyle = AquaToolbarLozengeButtonStyle(isOn: viewModel.isOn)
    Button("") {
      NSApp.sendAction(#selector(NSWindow.toggleToolbarShown(_:)), to: nil, from: self)
    }
    .buttonStyle(buttonStyle)
    .frame(width: 20, height: 8)
  }
}
