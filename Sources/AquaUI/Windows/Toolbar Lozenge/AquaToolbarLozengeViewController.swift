//
//  AquaToolbarLozengeViewController.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 29/12/2024.
//

import Cocoa
import SwiftUI

public class AquaToolbarLozengeViewController: NSTitlebarAccessoryViewController {
  @ObservedObject var viewModel: AquaToolbarLozengeViewModel = AquaToolbarLozengeViewModel()
  
  public override var isHidden: Bool {
    didSet {
      view.isHidden = isHidden
    }
  }
  
  public var toolbarShown: Bool = true {
    didSet {
      viewModel.isOn = !toolbarShown
    }
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    view.isHidden = self.isHidden
    
    let hostingView = FirstMouseHostingView(rootView: AquaToolbarLozengeView(viewModel: self.viewModel))
    hostingView.translatesAutoresizingMaskIntoConstraints = false
    layoutAttribute = .right
    view.addSubview(hostingView)
    view.addConstraint(hostingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -9))
    view.addConstraint(hostingView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 12))
  }
  
  public override func viewWillAppear() {
    super.viewWillAppear()
    view.setFrameSize(NSSize(width: 35.0, height: view.frame.size.height))
  }
}

