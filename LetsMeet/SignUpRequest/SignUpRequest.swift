//
//  SignUpRequest.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 09/11/22.
//

import Foundation



struct SignUpRequest:Encodable{
    
    let name:String
    let email:String
    let cityName:String
    let dateOfBirth:String
    let password:String
    let confirmPassword:String
    let genderType:String
    
}
