//
//  ContentView.swift
//  PackageExample
//
//  Created by bitcot on 28/07/23.
//

import SwiftUI
import BasicPackage2

struct ContentView: View {
    @State var getApiURL: String = "https://reqres.in/api/users/2"
    @State var postApiURL:String = "https://reqres.in/api/users"
    @State var getResponseJSON: [String:Any] = [:]
    
    var body: some View {
        VStack {
            Text("Welcome")
                .fontDesign(.rounded)
                .font(.largeTitle)
            Spacer()
            Button {
                //                getAPICall(url: apiURL)
//                postAPICall(url: postApiURL, param: ["name":"morpheus",
//                                             "job":"leader"])
                //                openLink(url: "https://www.bitcot.com")
                
                getResponseJSON = getAPICall(url: getApiURL)
                print(getResponseJSON)
            } label: {
                Text("Action")
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
