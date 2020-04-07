//
//  Spinner.swift
//  SwiftUI_SearchGithub
//
//  Created by 永田大祐 on 2020/04/07.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct Spinner: UIViewRepresentable {
    var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
