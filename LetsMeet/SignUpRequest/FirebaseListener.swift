//
//  FirebaseListener.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 01/12/22.
//

import Foundation
import Firebase

class FirebaseListener{
    
    
    static let shared = FirebaseListener()
    
    private init() {}
     
    // MARK: Fuser
    
    func downloadCurrentUserFromFirebase(userId:String,email:String){
        
        firebaseRefrence(collectionRefrence: .User).document(userId).getDocument {[weak self] snapShot, error in
            
            guard let snapShot = snapShot else { return }
            
            if snapShot.exists {
                
                guard let dictionary = snapShot.data() as NSDictionary? else {
                    return
                }
                
                let user = LoginManager(_dictionary: dictionary)
                user.saveUserInfo()
                
            }
            
            else
            {
                // If User Does not exits
                // First Login
                
                if let user = userDefaults.object(forKey: User.KCURRENTUSER) {
                    let dictionary = user as! NSDictionary
                    LoginManager(_dictionary: dictionary).saveUserToFireStore()
                }
                
               
                
            }
             
            
        }
    }
    
}
