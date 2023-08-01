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
            
            //GET API Button
            Button {
                getAPICall(url: getApiURL,
                           completion:
                            { jsonData, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "Error")
                    }else{
                        print(jsonData ?? [:])
                    }
                })
            } label: {
                Text("Get API")
            }
            
            //POST API Button
            Button {
                postAPICall(url: postApiURL,
                            param: ["name":"morpheus",
                                    "job":"leader"])
                { jsonData, error in
                    if error != nil {
                        print(error?.localizedDescription)
                    }else{
                        print(jsonData ?? [:])
                    }
                }
            } label: {
                Text("Post API")
            }
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
