//
//  LoginManager.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 01/12/22.
//

import Foundation
import Firebase
import UIKit


class LoginManager:Equatable {
    
    
    static func == (lhs: LoginManager, rhs: LoginManager) -> Bool {
       return lhs.objectId == rhs.objectId
    }
    
    var objectId :String = ""
    var email:String = ""
    var userName:String
    var dateOfBirth:Date
    var isMale:Bool
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
    
    init(objectId:String,email:String,userName:String,dateOfBirth:Date,isMale:Bool,proFession:String,country:String,jobTitle:String,about:String,city:String,height:String,lookingFor:String,avatarLink:String,linkedIdArray:[String]?,imageLinks:[String]?,registeredDate:Date,pushId:String) {
        self.objectId = objectId
        self.email = email
        self.userName = userName
        self.dateOfBirth = dateOfBirth
        self.isMale = isMale
        //self.profileImg = profileImg
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
    
    
    init(_dictionary:NSDictionary){
        
        self.objectId = _dictionary[User.KOBJECTID] as? String ?? ""
        self.email = _dictionary[User.KEMAIL] as? String ?? ""
        self.userName = _dictionary[User.KUSERNAME] as? String ?? ""
        
        
        
        self.dateOfBirth = _dictionary[User.KDATEOFBIRTH] as?  Date ?? Date()
        self.isMale =  _dictionary[User.KISMALE] as? Bool ?? true
        
        self.proFession = _dictionary[User.KPROFRESSION] as? String ?? ""
        self.jobTitle = _dictionary[User.KJOBTITLE] as? String ?? ""
        self.about = _dictionary[User.KABOUT] as? String ?? ""
        self.city = _dictionary[User.KCITY] as? String ?? ""
        self.height = _dictionary[User.KHEIGHT] as? String ?? ""
        self.country = _dictionary[User.KCOUNTRY] as? String ?? ""
        self.lookingFor = _dictionary[User.KLOOKINGFOR] as? String ?? ""
        self.avatarLink = _dictionary[User.KAVATARLINK] as? String ?? ""
        self.likedIdArray = _dictionary[User.KLIKEDIDARRAY] as? [String] ?? []
        self.imageLinks = _dictionary[User.KIMAGELINKS] as? [String] ?? []
        
        self.registeredDate = _dictionary[User.KREGISTEREDDATE] as? Date ?? Date()
        self.pushId = _dictionary[User.KPUSHID] as? String ?? ""
        
        
    }
    
    
    
    
    class func  loginUserWith( email:String,password:String,completion:@escaping( _ error:Error?,_ isEmailVerified:Bool)->Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if error == nil {
                
                if authResult!.user.isEmailVerified {
                    
                    // check If User Exits in
                    FirebaseListener.shared.downloadCurrentUserFromFirebase(userId: authResult!.user.uid, email: email)
                    completion(error,true)
                }
                
                else
                {
                    print("Email Id is not Varified please varify once before login")
                    completion(error, false)
                }
            }
            else
            {
                
                completion(error,false)
            }
        }
        
        firebaseRefrence(collectionRefrence: .User)
    }
    
    
    func saveUserInfo(){
        userDefaults.set(self.userInfoDictionary as! [String:Any], forKey: User.KCURRENTUSER)
        userDefaults.synchronize()
        
    }
    
    func saveUserToFireStore(){
        
        firebaseRefrence(collectionRefrence: .User).document(self.objectId).setData(self.userInfoDictionary as! [String:Any]) {[weak self] error in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    //MARK:- Reset Email Link
    
    class func resetPasswordFor(email:String, completion:@escaping (_ error: Error?)->Void){
        
        Auth.auth().currentUser?.reload(completion: { error in
            
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                
                completion(error)
            })
        })
    }
}
