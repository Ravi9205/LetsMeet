//
//  LoginValidation.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 31/10/22.
//

import Foundation


struct ValidationResult {
    var success: Bool = false
    var errorMessage: String?
}


struct LoginValidation {
    
    func validateUser(userEmail:String,password:String,isLogin:Bool)->ValidationResult {
        
        if isLogin {
            
            if (isValidEmail(value:userEmail) == false)
            {
                return ValidationResult(success: false, errorMessage: AlertMessages.incorrectEmail)
            }
        }
        else
        {
            if (userEmail.isEmpty || password.isEmpty) {
                
                return ValidationResult(success: false, errorMessage:AlertMessages.emptyCredentials)
            }
            
            if (isValidEmail(value:userEmail) == false)
            {
                return ValidationResult(success: false, errorMessage: AlertMessages.incorrectEmail)
            }
            
            if password.count < 7 {
                
                return ValidationResult(success: false, errorMessage:AlertMessages.passwordLength)
            }
            
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
