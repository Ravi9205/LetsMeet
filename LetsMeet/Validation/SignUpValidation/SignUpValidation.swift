//
//  SignUpValidationModel.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 09/11/22.
//

import Foundation





struct SignUpValidation{
    
    
    func validateNewUser(userName:String,userEmail:String,cityName:String,dateOfBirth:String,password:String,confirmPassword:String,genderType:String)-> ValidationResult{
        
        if (userName.isEmpty || userEmail.isEmpty || cityName.isEmpty || dateOfBirth.isEmpty || password.isEmpty || confirmPassword.isEmpty || genderType.isEmpty){
            
            return ValidationResult(success: false, errorMessage:AlertMessages.signUpEmptyCredentials)
        }
        
        if (isValidEmail(value:userEmail) == false)
        {
            return ValidationResult(success: false, errorMessage: AlertMessages.incorrectEmail)
        }
        
        if password.count < 7 {
            
            return ValidationResult(success: false, errorMessage:AlertMessages.passwordLength)
        }
        
        if password != confirmPassword {
            
            return ValidationResult(success: false, errorMessage: AlertMessages.confirmPassword)
        }
        
        return ValidationResult(success: true, errorMessage: nil)
        
    }
    
    
    //validate the email id
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
    
}


