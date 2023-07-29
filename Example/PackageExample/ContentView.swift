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
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Text("Welcome")
                .fontDesign(.rounded)
                .font(.largeTitle)
            Spacer()
            Button {
                isLoading = true
                    //getAPICall(url: apiURL)
                    //postAPICall(url: postApiURL, param: ["name":"morpheus",
                    //                                             "job":"leader"])
                    //                openLink(url: "https://www.bitcot.com")
                
//                getResponseJSON = getAPICall(url: getApiURL)
            } label: {
                if isLoading {
                    HStack(spacing: 15) {
                        ProgressView()
                        Text("Loading…")
                    }
                }else{
                    Text("Action")
                }
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
