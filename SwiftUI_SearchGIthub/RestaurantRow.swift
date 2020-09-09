//
//  RestaurantRow.swift
//  SampleList
//
//  Created by 永田大祐 on 2020/03/01.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import SwiftUI

struct RestaurantRow: View {

    var restaurant: Restaurant
    @ObservedObject var model: OrientationModel

    var body: some View {
        HStack {
            restaurant.body.map { m in
            ImageViewContainer(imageUrl: m)
            }.first
//            Button(action: {
//                self.model.invalid.toggle()
////                self.model.urlPath = self.restaurant.html_url?.absoluteString ?? ""
//            }, label: {
//                Text("GitHub login Name \(String(describing: self.model.name == "" ? "" : self.model.name))" +
//                    "\n" +
//                    "GitHub ID \(String(describing:  self.restaurant.id.description == "" ? "" : self.restaurant.id.description))")
//            })
        }
    }
}
