//
//  SignUpViewModel.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 08/11/22.
//

import Foundation



struct SignUpDataModel{
    var userName:String = String()
    var userEmail: String = String()
    var cityName:String = String()
    var genderType:String = String()
    var dateOfBirth:String = String()
    var password: String = String()
    var confirmPassword:String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErrorAlert: Bool = false
}

class SignUpViewModel {
    
    @Published var signUpDataModel:SignUpDataModel = SignUpDataModel()
    
    private let signUpValidation = SignUpValidation()
    private let signUpResource: SignUpResource = SignUpResource()
    
    
    func validateNewUserInputs() -> Bool
    {
        
        let result =  signUpValidation.validateNewUser(userName: signUpDataModel.userName, userEmail: signUpDataModel.userEmail, cityName: signUpDataModel.cityName, dateOfBirth: signUpDataModel.dateOfBirth, password: signUpDataModel.password, confirmPassword: signUpDataModel.confirmPassword, genderType: signUpDataModel.genderType)
        
        if result.success == false {
            signUpDataModel.errorMessage = result.errorMessage ?? "error occured"
            signUpDataModel.isPresentingErrorAlert = true
            return false
            
        }
        
        return true
    }
    
    
    
}
