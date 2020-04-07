//
//  ImageViewContainer.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI
import Combine

struct ImageViewContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL

    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 3.0))
            .frame(width: 70.0, height: 70.0)
            .aspectRatio(CGSize(width: 70.0, height: 70.0), contentMode: .fit)
    }
}

class RemoteImageURL: ObservableObject {
    @Published var data = Data()

    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async { self.data = data }

            }.resume()
    }
}
