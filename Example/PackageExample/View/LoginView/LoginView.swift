//
//  LoginView.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 02/08/23.
//

import SwiftUI
import BasicPackage2

//MARK: Main View
struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView()
                VStack {
                    if viewModel.showingLoader{
                        LoaderView(tintColor: .black, scaleSize: 2.0).hidden(viewModel.showingLoader)
                    }else{
                        TextFieldsView(vm: viewModel)
                        
                        //"email": "eve.holt@reqres.in",
//                        "password": "cityslicka"
                        
                        LoginButton(viewModel: viewModel)
                    }
                }
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
    }
}

//MARK: Header View
struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text("Login Page")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding()
    }
}

//MARK: Text Fields
struct TextFieldsView: View {
    @StateObject var vm: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $vm.email)
                .textInputAutocapitalization(.never)
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

//MARK: Login Button View
struct LoginButton: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        Button {
            viewModel.showingLoader = true
            let request = LoginRequest(email: viewModel.email,
                                    password: viewModel.password)
            
            if viewModel.isValidEmail(viewModel.email) {
                viewModel.callLoginAPI(loginReq: request)
            } else {
                viewModel.errorString = "Enter Valid Email"
                    viewModel.showingAlert = true
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
        .alert(viewModel.errorString, isPresented: $viewModel.showingAlert) {
            Button("Ok", role: .cancel) {
                
            }
        }

    }
}

//MARK: Loader View
struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    var body: some View {
        Spacer()
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle (CircularProgressViewStyle(tint: tintColor))
        Spacer()
    }
}

//MARK: Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
