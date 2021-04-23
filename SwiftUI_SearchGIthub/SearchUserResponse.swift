//
//  SearchUserResponse.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct SearchUserResponse: Decodable {
    var items: [GitHUbStruct]
}

struct GitHUbStruct: Hashable, Identifiable, Decodable {
    var login: String
    var id: Int
    var avatar_url: String
    var html_url: String
}
