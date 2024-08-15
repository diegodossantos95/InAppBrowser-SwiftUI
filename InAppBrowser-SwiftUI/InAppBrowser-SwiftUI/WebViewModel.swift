//
//  WebViewModel.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 08/08/24.
//

import Foundation
import WebKit

class WebViewModel: NSObject, ObservableObject, WKNavigationDelegate {

    // MARK: -  View state variables

    @Published var isLoading: Bool = false
    @Published var loadingProgress: Float = 0
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var title: String = ""

    // MARK: - WebView var

    weak var webView: WKWebView? {
        didSet {
            webView?.navigationDelegate = self
        }
    }

    // MARK: - Private observers

    private var loadingObserver: NSKeyValueObservation?
    private var loadingProgressObserver: NSKeyValueObservation?
    private var goBackObserver: NSKeyValueObservation?
    private var goForwardObserver: NSKeyValueObservation?
    private var pageTitleObserver: NSKeyValueObservation?

    // MARK: - Public navigation funcs

    func goBack() {
        webView?.goBack()
    }

    func goForward() {
        webView?.goForward()
    }

    func reload() {
        webView?.reload()
    }

    func openInExternalBrowser() {
        guard let url = webView?.url else { return }
        UIApplication.shared.open(url)
    }

    // MARK: - WKNavigationDelegate

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        setObservers()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        handleError(error)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        handleError(error)
    }

    // MARK: - Private funcs

    private func setObservers() {
        loadingObserver = webView?.observe(\.isLoading) { [weak self] webView, _ in
            self?.isLoading = webView.isLoading
        }

        loadingProgressObserver = webView?.observe(\.estimatedProgress)  { [weak self] webView, _ in
            self?.loadingProgress = Float(webView.estimatedProgress)
        }

        goBackObserver = webView?.observe(\.canGoBack) { [weak self] webView, _ in
            self?.canGoBack = webView.canGoBack
        }

        goForwardObserver = webView?.observe(\.canGoForward) { [weak self] webView, _ in
            self?.canGoForward = webView.canGoForward
        }

        pageTitleObserver = webView?.observe(\.title) { [weak self] webView, _ in
            self?.title = webView.title ?? ""
        }
    }

    private func handleError(_ error: Error) {
        print("error: \(error)")
    }
}
