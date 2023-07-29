//
//  ContentView.swift
//  PackageExample
//
//  Created by bitcot on 28/07/23.
//

import SwiftUI
import BasicPackage2

struct ContentView: View {
    @State var data: Data = Data()
    @State var apiURL: String = "https://reqres.in/api/users/2"
    
    var body: some View {
        VStack {
            Text("Welcome")
                .fontDesign(.rounded)
                .font(.largeTitle)
            Spacer()
            Button {
                //                data = getAPIData(url: apiURL)
                //                print(data.first)
                //                getAPICall(url: apiURL)
                postAPICall(url: "", param: ["name":"morpheus",
                                             "job":"leader"])
                //                openLink(url: "https://www.bitcot.com")
            } label: {
                Text("Know more about us!")
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
