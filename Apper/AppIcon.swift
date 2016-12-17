//
//  AppIcon.swift
//  Apper
//
//  Created by jian on 8/27/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

class AppIcon: NSObject
{
    var iconCode: String!
    var title: String!
    var isEmpty: Bool!
    
    init(icon: String, title: String)
    {
        super.init()
        
        self.iconCode = icon
        self.title = title
        self.isEmpty = false
    }
    
    override init()
    {
        super.init()
        
        self.isEmpty = true
    }
    
    func removeContent()
    {
        self.isEmpty = true
        self.iconCode = ""
        self.title = ""
    }
}
