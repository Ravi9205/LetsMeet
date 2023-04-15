//
//  Extensions.swift
//  LetsMeet
//
//  Created by Ravi Dwivedi on 05/12/22.
//

import Foundation
import UIKit

extension UIColor {
    
    func primanryColor() -> UIColor{
        return UIColor(red: 255/255, green: 45/255, blue: 85/255, alpha: 1)
    }
    
    func tapBarSelectedColor()-> UIColor{
        return UIColor(red: 255/255, green: 216/255, blue: 223/255, alpha: 1)
    }
    
}
 

extension Date{
    
    func longDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
        
    }
    
    func stringDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMMyyyyHHmmss"
        return dateFormatter.string(from: self)
    }
}
