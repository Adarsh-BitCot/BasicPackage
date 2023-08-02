//
//  ContentView.swift
//  PackageExample
//
//  Created by bitcot on 28/07/23.
//

import SwiftUI
import BasicPackage2

struct ContentView: View {
    @State var page: Int = 1
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Welcome")
                    .fontDesign(.rounded)
                    .font(.largeTitle)
                Spacer()
                
                
                
                //GET API Button
                Button {
                    getAPICall(url: apiURL.listOfUser(page: page),
                               type: BaseModel<ResponseData>.self)
                    { responseModel, error in
                        if let response = responseModel?.data {
                            print(response.first?.name ?? "")
                        } else {
                            print(error ?? "Error")
                        }
                    }
                } label: {
                    Text("Get API")
                }
                
                //POST API Button
                Button {
                    let params = [
                        "email": "eve.holt@reqres.in",
                        "password": "cityslicka"
                    ]
                    postAPICall(url: apiURL.create,
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
