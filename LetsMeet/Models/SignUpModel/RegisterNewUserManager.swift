//
//  RegisterNewUserManager.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 16/11/22.
//

import Foundation
import Firebase
import UIKit


class RegisterNewUserManager:Equatable {
    
    static func == (lhs: RegisterNewUserManager, rhs: RegisterNewUserManager) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
    var objectId :String = ""
    var email:String = ""
    var userName:String
    var dateOfBirth:Date
    var isMale:Bool
    var profileImg:UIImage?
    var proFession:String
    var jobTitle:String
    var about:String
    var city:String
    var country:String
    var height:String
    var lookingFor:String
    var avatarLink:String
    var likedIdArray:[String]?
    var imageLinks:[String]?
    var registeredDate = Date()
    var pushId:String?
    
    
    var userInfoDictionary:NSDictionary{
        
        return NSDictionary(objects: [
            self.objectId,
            self.email,
            self.userName,
            self.dateOfBirth,
            self.isMale,
            self.proFession,
            self.jobTitle,
            self.about,
            self.city,
            self.country,
            self.height,
            self.lookingFor,
            self.avatarLink,
            self.likedIdArray ?? [],
            self.imageLinks ?? [],
            self.registeredDate,
            self.pushId!
            
        ], forKeys: [ User.KOBJECTID as NSCopying,
                      User.KEMAIL as NSCopying,
                      User.KUSERNAME as NSCopying,
                      User.KDATEOFBIRTH as NSCopying,
                      User.KISMALE as NSCopying,
                      User.KPROFRESSION as NSCopying,
                      User.KJOBTITLE as NSCopying,
                      User.KABOUT as NSCopying,
                      User.KCITY as NSCopying,
                      User.KCOUNTRY as NSCopying,
                      User.KHEIGHT as NSCopying,
                      User.KLOOKINGFOR as NSCopying,
                      User.KAVATARLINK as NSCopying,
                      User.KLIKEDIDARRAY as NSCopying,
                      User.KIMAGELINKS as NSCopying,
                      User.KREGISTEREDDATE as NSCopying,
                      User.KPUSHID as NSCopying
                    ])
    }
    
    init(objectId:String,email:String,userName:String,dateOfBirth:Date,isMale:Bool,profileImg:UIImage,proFession:String,country:String,jobTitle:String,about:String,city:String,height:String,lookingFor:String,avatarLink:String,linkedIdArray:[String]?,imageLinks:[String]?,registeredDate:Date,pushId:String) {
        self.objectId = objectId
        self.email = email
        self.userName = userName
        self.dateOfBirth = dateOfBirth
        self.isMale = isMale
        self.profileImg = profileImg
        self.proFession = proFession
        self.jobTitle = jobTitle
        self.about = about
        self.city = city
        self.height = height
        self.country = country
        self.lookingFor = lookingFor
        self.avatarLink = avatarLink
        self.likedIdArray = linkedIdArray
        self.imageLinks = imageLinks
        self.registeredDate = registeredDate
        self.pushId = pushId
        
    }
    
    class func registerNewUserWith(email:String,password:String,userName:String,city:String,genderType:String,dateofBirth:Date,completion:@escaping (_ error:Error?)->Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            
            completion(error)
            
            if error == nil {
                
                guard let data = authDataResult?.user else {
                    return
                }
                
                data.sendEmailVerification { error in
                    
                    if error == nil {
                        print("Varification sent to the registered email id")
                    }
                    else
                    {
                        print("Failed to sent email to the register email id")
                    }
                    
                    if authDataResult?.user != nil {
                        
                        let user = RegisterNewUserManager(objectId: authDataResult!.user.uid, email: email, userName: userName, dateOfBirth: dateofBirth, isMale: true, profileImg:UIImage(), proFession:"", country:"", jobTitle:"", about:"", city: city, height:"", lookingFor: "", avatarLink:"", linkedIdArray: [], imageLinks: [], registeredDate: Date(), pushId: "")
                        user.saveUserInfo()
                        
                    }
                    
                    // print("User Registered Successfully......\(data)")
                }
            }
        }
    }
    
    func saveUserInfo(){
        userDefaults.set(self.userInfoDictionary as! [String:Any], forKey: User.KCURRENTUSER)
        userDefaults.synchronize()
        
    }
}

