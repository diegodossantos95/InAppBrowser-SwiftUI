//
//  WebViewWrapper.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 02/08/24.
//

import SwiftUI
import WebKit

struct WebViewWrapper: UIViewRepresentable {

    // MARK: -  Public vars

    var url: URL
    @ObservedObject var viewModel: WebViewModel

    // MARK: -  UIViewRepresentable

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        viewModel.webView = webView
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
