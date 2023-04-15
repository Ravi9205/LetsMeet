//
//  LoginRequest.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 01/11/22.
//

import Foundation


struct LoginRequest:Encodable {
    let userEmail, userPassword:String
}

