//
//  ContentView.swift
//  SwiftUI_SearchGIthub
//
//  Created by 永田大祐 on 2020/03/04.
//  Copyright © 2020 永田大祐. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {

    @State var name = ""
    @ObservedObject var viewModel = OrientationModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TextField("姓",
                              text: self.$name,
                              onEditingChanged: { begin in
                                if begin {
                                    self.viewModel.name = self.name
                                    self.viewModel.search()
                                } else {
                                    self.viewModel.name = self.name
                                    self.viewModel.search()
                                }},
                              onCommit: validate)

                    List(viewModel.users) { restaurant in
                        RestaurantRow(restaurant: restaurant, model: self.viewModel)
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .navigationBarItems(leading:
                    HStack {
                        Button(action: {
                            self.viewModel.invalid.toggle()
                        }, label: {
                            Text("Back")
                        })
                    }, trailing:
                    HStack {
                        Button(action: {
                            self.viewModel.users.removeAll()
                        }, label: {
                            Text("Rest")
                        })
                })
                .navigationBarTitle(Text("Users"))
    
                if self.viewModel.invalid == true {
                    ContentWebView(urlPath: self.viewModel.urlPath)
                }
                self.viewModel.isAnimating()
            }
        }
    }

    func validate() {
        self.viewModel.invalid = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
