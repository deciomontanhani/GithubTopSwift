//
//  NSObject.swift
//  GithubTopSwift
//
//  Created by Decio Montanhani on 06/05/19.
//  Copyright © 2019 Décio Montanhani. All rights reserved.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
