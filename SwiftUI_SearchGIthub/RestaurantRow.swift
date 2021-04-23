//
//  RestaurantRow.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct RestaurantRow: View {

    var gitHUbStruct: GitHUbStruct
    @ObservedObject var model: OrientationModel

    var body: some View {
        HStack {
            ImageViewContainer(imageUrl: gitHUbStruct.avatar_url)
            Button(action: {
                self.model.invalid.toggle()
            }, label: {
                Text("GitHub login Name \(String(describing: self.model.name == "" ? "" : self.model.name))" +
                    "\n" +
                    "GitHub ID \(String(describing:  self.gitHUbStruct.id.description == "" ? "" : self.gitHUbStruct.id.description))")
            })
        }
    }
}
