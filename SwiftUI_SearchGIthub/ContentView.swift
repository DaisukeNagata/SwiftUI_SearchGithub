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
                                self.viewModel.name = self.name
                                self.viewModel.search()
                              },
                              onCommit: validate)

                    List(viewModel.users) { value in
                        RestaurantRow(gitHUbStruct: value, model: self.viewModel)
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .navigationBarItems(leading:
                        Button(action: {
                            self.viewModel.invalid.toggle()
                        }, label: {
                            Text("Back")
                        }),trailing:
                        Button(action: {
                            self.viewModel.users.removeAll()
                        }, label: {
                            Text("Rest")
                        })
                )
                .navigationBarTitle(Text("Users"))
    
                if self.viewModel.invalid {
                    ContentWebView(viewModel: viewModel)
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
