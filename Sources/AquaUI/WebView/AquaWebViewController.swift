//
//  AquaWebViewController.swift
//  AquaUI
//
//  Created by Jonathan Sterling on 15/01/2025.
//

import Cocoa
import WebKit

/// This is a hack, but it works. It is not possible to customise `WKWebView`'s own scrollbars, because these are rendered using some private APIs rather than via an `NSScrollView`. Instead, we do the following:
/// 1. We use a subclass `NonscrollingWebView` of `WKWebView` in which scroll-wheel events are ignored and forwarded to the next responder.
/// 2. We wrap our web view in our own (aqua) scroll view, which will receive the scroll-wheel events that were forwarded above.
/// 3. We equip the web view with a user script that observes the physical height of the `body` element and sends this in a message to the view controller.
/// 4. When view controller receives this message, it updates the height of the web view accordingly.
///
/// In other words, the web view is ensured to be of full height at all times, and the scroll view is responsible for clipping and scrolling.
///
open class AquaWebViewController : NSViewController, WKScriptMessageHandler {
  public let webView = NonscrollingWebView()
  public let scrollView = NSScrollView.aquaScrollView()
  
  static let sizeNotificationMessageName = "aquaWebViewControllerSizeNotification"
  static let debugNotificationMessageName = "aquaWebViewControllerDebugNotification"
  
  open override func loadView() {
    super.loadView()
   
    view = scrollView
    view.autoresizesSubviews = true
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.documentView = webView
    
    webView.frame = view.bounds
    webView.autoresizingMask = [.minXMargin, .maxXMargin, .width, .height]
    
    let source = """
    function initialiseObservers() {
      const observer = new ResizeObserver(entries => {
        for (const entry of entries) {
          window.webkit.messageHandlers.\(Self.sizeNotificationMessageName).postMessage({height: entry.contentRect.height})
        }
      })
      observer.observe(document.body)
      window.webkit.messageHandlers.\(Self.sizeNotificationMessageName).postMessage({height: document.body.height})
    }
    
    document.addEventListener('DOMContentLoaded', function () {
      document.body.style.height = '100%'
      document.body.style.overflow = 'hidden'
      initialiseObservers();
    });
    """
    
    let userContentController = webView.configuration.userContentController
    let script = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: true)
    userContentController.addUserScript(script)
    userContentController.add(self, name: Self.sizeNotificationMessageName)
    userContentController.add(self, name: Self.debugNotificationMessageName)
  }
  
  open func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    switch message.name {
    case Self.debugNotificationMessageName:
      dump(message.body)
      return
    case Self.sizeNotificationMessageName:
      guard
        let responseDict = message.body as? [String:Any],
        let height = responseDict["height"] as? Float
      else { return }
      let size = NSSize(width: scrollView.contentView.frame.width, height: CGFloat(height))
      webView.frame = NSRect(origin: .zero, size: size)
    default:
      return
    }
  }
}

#Preview() {
  let controller = AquaWebViewController()
  let _ = controller.webView.load(URLRequest(url: URL(string: "https://www.jonmsterling.com/")!))
  controller
}
