//
//  InAppBrowserView.swift
//  InAppBrowser-SwiftUI
//
//  Created by Diego Dos Santos on 08/08/24.
//

import SwiftUI

struct InAppBrowserView: View {

    // MARK: -  Private vars

    @ObservedObject private var viewModel = WebViewModel()

    // MARK: -  Public vars

    var url: URL

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                WebViewWrapper(url: url, viewModel: viewModel)

                Divider()

                HStack {
                    Button {
                        viewModel.goBack()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                    .disabled(!viewModel.canGoBack)

                    Spacer()

                    Button {
                        viewModel.goForward()
                    } label: {
                        Image(systemName: "chevron.forward")
                    }
                    .disabled(!viewModel.canGoForward)

                    Spacer()

                    Button {
                        viewModel.openInExternalBrowser()
                    } label: {
                        Image(systemName: "safari")
                    }

                    Spacer()

                    Button {
                        viewModel.reload()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                .padding(.horizontal, 12)
                .frame(height: 56)
            }

            if viewModel.isLoading {
                ProgressView(value: viewModel.loadingProgress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .frame(height: 1)
            }
        }
        .navigationBarTitle(viewModel.title)
    }
}

#Preview {
    InAppBrowserView(url: URL(string: "https://medium.com/@diegodossantos1")!)
}
