//
//  Restaurant.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct SearchUserResponse: Decodable {
    var items: [Restaurant]
}

struct Restaurant: Hashable, Identifiable, Decodable {
    var id: Int
    var score: Double
    var login: String? = nil
    var avatar_url: URL? = nil
    var html_url: URL? = nil
}
