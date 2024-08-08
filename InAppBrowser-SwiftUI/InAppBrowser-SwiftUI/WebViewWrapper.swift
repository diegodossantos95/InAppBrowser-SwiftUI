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
    @ObservedObject var viewModel: WebViewModel

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        context.coordinator.webView = webView
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }
}

extension WebViewWrapper {
    class Coordinator: NSObject, WKNavigationDelegate {

        @ObservedObject private var viewModel: WebViewModel
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

        init(viewModel: WebViewModel) {
            self.viewModel = viewModel
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
            loadingObserver = webView?.observe(\.isLoading) { [weak self] webView, _ in
                self?.viewModel.isLoading = webView.isLoading
            }

            loadingProgressObserver = webView?.observe(\.estimatedProgress)  { [weak self] webView, _ in
                self?.viewModel.loadingProgress = Float(webView.estimatedProgress)
            }

            goBackObserver = webView?.observe(\.canGoBack) { [weak self] webView, _ in
                self?.viewModel.canGoBack = webView.canGoBack
            }

            goForwardObserver = webView?.observe(\.canGoForward) { [weak self] webView, _ in
                self?.viewModel.canGoForward = webView.canGoForward
            }

            pageTitleObserver = webView?.observe(\.title) { [weak self] webView, _ in
                self?.viewModel.title = webView.title ?? ""
            }
        }

        private func handleError(_ error: Error) {
            print("error: \(error)")
        }
    }
}
