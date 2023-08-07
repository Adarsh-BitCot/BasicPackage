//
//  ContentView.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 28/07/23.
//

import SwiftUI
import BasicPackage2

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("Welcome")
                    .fontDesign(.rounded)
                    .font(.largeTitle)
                Spacer()
                
                //Website Button
                Button {
                    openLink(url: "https://www.bitcot.com")
                } label: {
                    Text("Open Website")
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
