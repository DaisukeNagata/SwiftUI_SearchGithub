//
//  OrientationModel.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI
import Combine

final class OrientationModel: ObservableObject {
    
    @Published var spinner = Spinner(isAnimating: true, style: .large) 

    @Published var urlPathSet = "https://api.github.com/search/users"
    @Published var users = [GitHUbStruct]()
    @Published var invalid = false
    @Published var urlPath = ""
    @Published var name = ""
    
    init() {
        self.spinner.isAnimating = false
    }

    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func isAnimating() -> some View {
        if self.spinner.isAnimating {
            return  self.spinner
        } else {
            _ = self.spinner.hidden()
            return  self.spinner
        }
    }
        
    func search() {

        guard !name.isEmpty else {
            return users = []
        }
        
        self.spinner.isAnimating = true

        var urlComponents = URLComponents(string: urlPathSet)!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: name)
        ]

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }, receiveValue: { user in
            self.spinner.isAnimating = false
            user.forEach { [self] v in
                urlPath = v.html_url
            }
            // this is sorted
            self.users =  user.sorted { (l, r) -> Bool in
                if l.id < r.id {
                    return false
                } else {
                    return true
                }
            }
        })
    }
}
