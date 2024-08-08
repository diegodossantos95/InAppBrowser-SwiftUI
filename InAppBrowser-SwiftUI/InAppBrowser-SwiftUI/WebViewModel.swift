//
//  WebViewModel.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 08/08/24.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var loadingProgress: Float = 0
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var title: String = ""
}
