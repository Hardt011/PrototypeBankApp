//
//  Extentions.swift
//  AppTesteBanco
//
//  Created by Virtual Machine on 18/10/21.
//

import Foundation
import UIKit

extension UIViewController {

    class func instantiateFromStoryboard (_ name: String ) -> Self
    {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T> (_ name: String) -> T
    {
        let storyboard = UIStoryboard (name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(Self.self)")
        as! T
        return controller
        
    }

}

extension UIView {
    
    func roundCorners(cornerRadius: CGFloat, typeCorners: CACornerMask){
        
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = typeCorners
        self.clipsToBounds = false
        
    }
    
}

extension CACornerMask {
    
    static public let inferiorDireito: CACornerMask = .layerMaxXMaxYCorner
    static public let inferiorEsquerdo: CACornerMask = .layerMinXMaxYCorner
    static public let superiorDireito: CACornerMask = .layerMaxXMinYCorner
    static public let superiorEsquerdo: CACornerMask = .layerMinXMinYCorner
    
}
