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

    @ObservedObject var viewModel: OrientationModel
    
    var body: some View {
        WebView(loadUrl: self.viewModel.urlPath).edgesIgnoringSafeArea(.bottom)
    }
}

struct WebView: UIViewRepresentable {
    var loadUrl:String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: URL(string: loadUrl)!))
    }
}
