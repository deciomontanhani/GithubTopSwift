//
//  UINavigation.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 07/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import UIKit

@objc
extension UINavigationBar {
   
    @objc func setDarkStyle() {
        barStyle = .default
        isTranslucent = false
        shadowImage = nil
        
        barTintColor = UIColor.black
        
        titleTextAttributes = [.foregroundColor: UIColor.white]
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        
        
    }
}
