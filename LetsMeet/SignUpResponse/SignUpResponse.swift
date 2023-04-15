//
//  SignUpResponse.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 09/11/22.
//

import Foundation


struct SignUpResponse {
    let errorMessage: String?
    let data: SignUpResponseData?
    
}

struct SignUpResponseData{
    var name:String
    var email:String
    var city:String
    var genderType:String
}
