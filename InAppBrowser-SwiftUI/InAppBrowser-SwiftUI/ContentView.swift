//
//  ContentView.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 02/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WebViewWrapper(url: URL(string: "https://medium.com/@diegodossantos1")!)
    }
}

#Preview {
    ContentView()
}
