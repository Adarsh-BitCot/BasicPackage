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
    @State var apiURL: String = "https://reqres.in/api/users?page=2"
    
    var body: some View {
        VStack {
            Text("Users available")
                .fontDesign(.rounded)
                .font(.largeTitle)
            Spacer()
            Button {
//                data = getAPIData(url: apiURL)
//                print(data.first)
            } label: {
                Text("Get User list")
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
