//
//  Constants.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 27/10/22.
//

import Foundation

public let userDefaults = UserDefaults.standard



struct  ViewControllerIdentifier{
    
    static let signUpView = "SignUpViewController"
    static let forgotPasswordView = "ForgotPasswordViewController"
    static let homeView = "HomeViewController"
    
}





struct AlertMessages {
    static let  emptyCredentials = "User email and password Field can't be empty"
    static let incorrectEmail = "User Email Formate is in correct"
    static let passwordLength = "Password length should be greater than 7"
    static let emptyEmail = "Please insert your email Address "
    static let confirmPassword = "New Password and confirm should be the same"
    static let signUpEmptyCredentials = "All Fields are required"
}


struct User{
    
    static let KOBJECTID = "objectId"
    static let KEMAIL = "email"
    static let KUSERNAME = "username"
    static let KDATEOFBIRTH = "dateOfBirth"
    static let KISMALE = "isMale"
    static let KPROFRESSION = "profression"
    static let KJOBTITLE = "jobtitle"
    static let KABOUT = "about"
    static let KCITY = "city"
    static let KCOUNTRY = "country"
    static let KHEIGHT = "height"
    static let KLOOKINGFOR = "lookingFor"
    static let KAVATARLINK  = "avatarLink"
    static let KLIKEDIDARRAY = "likedIdArray"
    static let KIMAGELINKS = "imageLinks"
    static let KREGISTEREDDATE = "registeredDate"
    static let KPUSHID = "pushId"
    static let KCURRENTUSER = "currentUser"
    static let KPROFILEIMAGE = "ProfileImage"
    
}

