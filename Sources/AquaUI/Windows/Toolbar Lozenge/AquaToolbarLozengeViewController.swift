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
  
  var windowToolbarStyle: NSWindow.ToolbarStyle = .expanded {
    didSet {
      updateVerticalConstraint()
    }
  }
  
  var verticalConstraint: NSLayoutConstraint?
  
  public var toolbarShown: Bool = true {
    didSet {
      viewModel.isOn = !toolbarShown
      updateVerticalConstraint()
    }
  }
  
  var verticalConstraintConstant: CGFloat {
    if !toolbarShown { return 12 }
    switch windowToolbarStyle {
    case .preference:
      return 12
    case .expanded:
      return 12
    case .unifiedCompact:
      return 16
    case .unified:
      return 21
    case .automatic:
      return 21
    default:
      return 12
    }
  }
  
  func updateVerticalConstraint() {
    verticalConstraint?.constant = verticalConstraintConstant
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    let hostingView = FirstMouseHostingView(rootView: AquaToolbarLozengeView(viewModel: self.viewModel))
    hostingView.translatesAutoresizingMaskIntoConstraints = false
    layoutAttribute = .right
    view.addSubview(hostingView)
    
    view.addConstraint(hostingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -9))
    
    verticalConstraint = hostingView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 0)
    view.addConstraint(verticalConstraint!)
    
    updateVerticalConstraint()
  }
  
  public override func viewWillAppear() {
    super.viewWillAppear()
    view.setFrameSize(NSSize(width: 35.0, height: view.frame.size.height))
  }
}

