//
//  OrientationModel.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI
import Combine

class observable: ObservableObject {
    @Published var observation: NSKeyValueObservation?
}

final class OrientationModel: ObservableObject {

    @Published var urlPathSet = "https://api.github.com/search/users"
    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var users = [Restaurant]()
    @Published var invalid = false
    @Published var urlPath = ""
    @Published var name = ""
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        cancellable?.cancel()
    }
        
    func search() {
        guard !name.isEmpty else {
            return users = []
        }
        
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
            // this is sorted
            self.users =  user.sorted { (l, r) -> Bool in
                if l.id < r.id {
                    return false
                } else {
                    return true
                }
            }
            print(self.users)
        })
    }
}
