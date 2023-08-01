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
    @State var postResponse: BaseModel<ResponseData>?
    
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
                    if let response = responseModel?.data {
                        print(response.email ?? "")
                    } else {
                        print(error ?? "Error")
                    }
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
