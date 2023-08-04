//
//  LoginView.swift
//  PackageExample
//
//  Created by bitcot on 02/08/23.
//

import SwiftUI
import BasicPackage2

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var showingAlert = false
    @State var errorString: String = "Error"
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HeaderView()
                VStack {
                    TextFieldsView(vm: viewModel)
                    Button {
                        let params = ["email": viewModel.email,
                                      "password": viewModel.password]
                        
                        if viewModel.isValidEmail(viewModel.email) {
                            postAPICall(url: apiURL.login,
                                        param: params,
                                        type: BaseModel<ResponseData>.self)
                            { response, error in
                                if let response = response {
                                    if let error = response.error{
                                        errorString = error
                                        showingAlert = true
                                    }else{
                                        viewModel.isLogin = true
                                    }
                                }else{
                                    errorString = error ?? ""
                                    showingAlert = true
                                }
                            }
                        } else {
                            errorString = "Enter Valid Email"
                            showingAlert = true
                        }
                    } label: {
                        Text("Login")
                            .frame(width: 300, height: 25)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .navigationDestination(isPresented: $viewModel.isLogin) {
                                ContentView()
                            }
                    }
                    .alert(errorString, isPresented: $showingAlert) {
                        Button("Ok", role: .cancel) {
                            
                        }
                    }
                    
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding()
    }
}

struct TextFieldsView: View {
    
    @StateObject var vm: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $vm.email)
                .frame(height: 50)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 6))
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray,lineWidth: 1))
                .font(.system(size: 16))
            
            SecureField("Password", text: $vm.password)
                .frame(height: 50)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 6))
                .background(Color.white)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray,lineWidth: 1))
                .font(.system(size: 16))
        }.padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
