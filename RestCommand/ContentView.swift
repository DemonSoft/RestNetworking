//
//  ContentView.swift
//  RestCommand
//
//  Created by Dmitriy Soloshenko on 01.11.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model    = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button {
                model.shortGetRequest()
            } label: {
                Text("SHORT GET REQUEST")
            }
            .padding()

            Button {
                model.getRequest()
            } label: {
                Text("GET REQUEST WIT CALLBACK")
            }
            .padding()

            Button {
                model.postRequest()
            } label: {
                Text("POST REQUEST")
            }
            .padding()
            
            VStack {
                Text("RESULT:")
                Text(model.result)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
