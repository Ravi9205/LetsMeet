//
//  LoginViewModel.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 03/11/22.
//

import Foundation


struct LoginDataModel{
    var userEmail: String = String()
    var userPassword: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
    var isLogin:Bool = false
}


class LoginViewModel {
    
    
    @Published var loginDataModel: LoginDataModel = LoginDataModel()
    private let loginValidation = LoginValidation()
    private let loginResource: LoginResource = LoginResource()
    
    // validate the user inputs
    func validateUserInputs() -> Bool {

        let result = loginValidation.validateUser(userEmail: loginDataModel.userEmail, password: loginDataModel.userPassword, isLogin: loginDataModel.isLogin)
        
        if(result.success == false){
            loginDataModel.errorMessage = result.errorMessage ?? "error occured"
            loginDataModel.isPresentingErrorAlert = true
            
            return false
        }

        return true
        
    }
    
    
     
    
    //call the api
    func authenticateUser() {

        let request = LoginRequest(userEmail: loginDataModel.userEmail, userPassword: loginDataModel.userPassword)
        
        loginResource.authenticateUser(loginRequest: request) { response in
            DispatchQueue.main.async {
                if(response.errorMessage == nil){
                    self.loginDataModel.navigate = true
                }
                else{
                    self.loginDataModel.errorMessage = response.errorMessage ?? "error occured"
                    self.loginDataModel.isPresentingErrorAlert = true
                }
            }
        }
    }
    
    
}
