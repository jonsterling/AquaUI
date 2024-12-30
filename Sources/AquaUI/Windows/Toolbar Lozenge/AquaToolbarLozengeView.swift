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
      // Although the state of this view is ultimately controlled from outside in response to toolbar visibility changes, we also toggle the state here in order to avoid the awkward "flashing" caused by the transition sequence (pressed, off) -> (unpressed, off) -> (unpressed, on). By toggling the state locally, that sequence is replaced by (pressed, off) -> (unpressed, on).
      viewModel.isOn.toggle()
      NSApp.sendAction(#selector(NSWindow.toggleToolbarShown(_:)), to: nil, from: self)
    }
    .buttonStyle(buttonStyle)
    .frame(width: 22, height: 9)
  }
}
