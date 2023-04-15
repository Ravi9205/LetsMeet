//
//  FirebaseUser.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 01/12/22.
//

import Foundation
import FirebaseFirestore


enum FcollcetionRefrence:String{
    case User
    
}


func firebaseRefrence(collectionRefrence:FcollcetionRefrence)-> CollectionReference {
        
    return Firestore.firestore().collection(collectionRefrence.rawValue)
    
}
