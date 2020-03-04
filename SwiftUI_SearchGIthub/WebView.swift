//
//  WebView.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI
import WebKit

struct ContentWebView: View {
    var urlPath: String
    var body: some View {
        WebView(loadUrl: urlPath).edgesIgnoringSafeArea(.bottom)
    }
}

struct WebView: UIViewRepresentable {
    var loadUrl:String
    @ObservedObject var observe = observable()

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        observe.observation = uiView.observe(\WKWebView.url, options: .new) { view, change in
            if let url = uiView.url {
                print("Page loaded: \(url)")
            }
        }
        uiView.load(URLRequest(url: URL(string: loadUrl)!))
    }
}
