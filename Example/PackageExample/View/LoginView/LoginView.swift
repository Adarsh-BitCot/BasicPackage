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
    @State private var showingLoader = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HeaderView()
                VStack {
                    if showingLoader{
                        LoaderView(tintColor: .black, scaleSize: 2.0).hidden(showingLoader)
                    }else{
                        TextFieldsView(vm: viewModel)
                        
                        LoginButton(viewModel: viewModel,
                                    showingLoader: showingLoader)
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
            Text("Login")
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
    @State var errorString: String = "Error"
    @State private var showingAlert = false
    @State var showingLoader: Bool
    
    var body: some View {
        Button {
            self.showingLoader = true
            let body = ["email": viewModel.email,
                          "password": viewModel.password]
            
            if viewModel.isValidEmail(viewModel.email) {
                callApiWithSPM(url: apiURL.reqresLogin,
                            body: body,
                            type: BaseModel<ResponseData>.self)
                { response, error in
                    self.showingLoader = false
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
}

//MARK: Loader View
struct LoaderView: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle (CircularProgressViewStyle(tint: tintColor))
    }
}

//MARK: Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
