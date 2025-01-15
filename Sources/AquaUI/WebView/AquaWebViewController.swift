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
  
  static let sizeNotificationMessageName = "sizeNotification"
  
  override func loadView() {
    super.loadView()
    
    view = scrollView
    view.autoresizesSubviews = true
  }
  
  override func viewDidLoad() {
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
      initialiseObservers();
    });
    """
    
    let script = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: true)
    webView.configuration.userContentController.addUserScript(script)
    webView.configuration.userContentController.add(self, name: Self.sizeNotificationMessageName)
  }
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard
      message.name == Self.sizeNotificationMessageName,
      let responseDict = message.body as? [String:Any],
      let height = responseDict["height"] as? Float
    else { return }
    
    webView.frame = NSRect(x: 0.0, y: 0.0, width: view.frame.width - 20, height: CGFloat(height))
  }
}
