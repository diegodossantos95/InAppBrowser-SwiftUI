//
//  WebViewWrapper.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 02/08/24.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        context.coordinator.webView = webView
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension WebViewWrapper {
    class Coordinator: NSObject, WKNavigationDelegate {

        private var loadingObserver: NSKeyValueObservation?
        private var loadingProgressObserver: NSKeyValueObservation?
        private var goBackObserver: NSKeyValueObservation?
        private var goForwardObserver: NSKeyValueObservation?
        private var pageTitleObserver: NSKeyValueObservation?
       
        weak var webView: WKWebView? {
            didSet {
                webView?.navigationDelegate = self
            }
        }

        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            setObservers()
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            handleError(error)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            handleError(error)
        }

        private func setObservers() {
            loadingObserver = webView?.observe(\.isLoading) { webView, _ in
                print("isLoading: \(webView.isLoading)")
            }

            loadingProgressObserver = webView?.observe(\.estimatedProgress)  { webView, _ in
                print("estimatedProgress: \(Float(webView.estimatedProgress))")
            }

            goBackObserver = webView?.observe(\.canGoBack) { webView, _ in
                print("canGoBack: \(webView.canGoBack)")
            }

            goForwardObserver = webView?.observe(\.canGoForward) { webView, _ in
                print("canGoForward: \(webView.canGoForward)")
            }

            pageTitleObserver = webView?.observe(\.title) { webView, _ in
                print("title: \(webView.title ?? "")")
            }
        }

        private func handleError(_ error: Error) {
            print("error: \(error)")
        }
    }
}
