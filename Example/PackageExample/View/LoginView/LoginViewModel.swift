//
//  LoginViewModel.swift
//  PackageExample
//
//  Created by Adarsh Sharma on 02/08/23.
//

import Foundation
import BasicPackage2

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogin: Bool = false
    @Published var errorString: String = "Error"
    @Published var showingAlert = false
    @Published var showingLoader = false
    
    func isValidEmail(_ email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: email)
         }
    
    func callLoginAPI(loginReq: LoginRequest){
        print(loginReq.toDictionary())
        
        callApiWithSPM(url: ApiURL.reqresLogin,
                       body: loginReq.toDictionary(),
                       type: BaseModel<ResponseData>.self,
                       method: HttpMethod.post)
        { response, error in
            self.showingLoader = false
            if let response = response {
                if let error = response.error{
                    self.errorString = error
                    self.showingAlert = true
                }else{
                    self.isLogin = true
                }
            }else{
                self.errorString = error ?? ""
                self.showingAlert = true
            }
        }
    }
}

struct LoginRequest: Encodable {
    var email: String?
    var password: String?
    
    init(email: String? = .none,
         password: String? = .none) {
        
        self.email = email
        self.password = password
    }
}
