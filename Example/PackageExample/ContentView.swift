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
                //                openLink(url: "https://www.bitcot.com")
                getAPICall(url: getApiURL, completion: { jsonData, error in
                    if error != nil {
                        print(error?.localizedDescription)
                    }else{
                        print(jsonData)
                    }
                })
            } label: {
                Text("Get API")
            }
            
            Button {
//                ["name":"morpheus", "job":"leader"]
                //                openLink(url: "https://www.bitcot.com")
            } label: {
                Text("Post API")
            }
            
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
