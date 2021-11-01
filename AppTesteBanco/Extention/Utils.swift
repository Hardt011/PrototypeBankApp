//
//  numberFormatter.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 21/10/21.
//

import Foundation
import UIKit

class Utils{
    class func  numberFormatter (value: Double) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = Locale(identifier: "pt_BR")
        
        
        
        return String (nf.string(for: value) ?? value as! String )
    }
    
    class func formatDate(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm.ss'Z'"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        let dateObj: Date? = dateFormatterGet.date(from: date)
        
        return dateFormatter.string(from: dateObj!)
    }
        
       class func cpfFormatter (cpfString: String) -> String {
            
            var cpfArray : [Character] = []
            for letter in cpfString {
                
                cpfArray.append(letter)
                
            }
            
            cpfArray.insert(".", at: 3)
            cpfArray.insert(".", at: 7)
            cpfArray.insert("-", at: 11)
            
            return String (cpfArray)
            
        }
        
    }
    
    
    


