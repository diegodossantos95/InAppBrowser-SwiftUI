//
//  ContentView.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 02/08/24.
//

import SwiftUI

struct ContentView: View {

    @State private var showingPopover = false

    var body: some View {
        Button("Show In-App Browser") {
            showingPopover = true
        }
        .popover(isPresented: $showingPopover) {
            NavigationView {
                InAppBrowserView(url: URL(string: "https://medium.com/@diegodossantos1")!)
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    ContentView()
}
