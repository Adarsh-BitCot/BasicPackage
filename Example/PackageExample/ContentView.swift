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
                           type: BaseModel<ResponseData>.self)
                { responseModel, error in
                    print(responseModel?.data?.first_name ?? "")
                }
            } label: {
                Text("Get API")
            }
            
            //POST API Button
            Button {
                let params = ["name":"morpheus","job":"leader"]
                postAPICall(url: postApiURL,
                            param: params,
                            type: BaseModel<ResponseData>.self)
                { responseModel, error in
                    print(responseModel?.job ?? "")
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
