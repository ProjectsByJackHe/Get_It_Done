//
//  profile.swift
//  Get_It_Done
//
//  Created by Jack He on 1/12/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit

class Profile {
    var name: String
    var repPoints: String
    var skill1: String
    var skill2: String
    var skill3: String
    var email: String
    
    init(name:String, repPoints:String, skill1:String, skill2:String, skill3:String, email:String){
        self.name = name
        self.repPoints = repPoints
        self.skill1 = skill1
        self.skill2 = skill2
        self.skill3 = skill3
        self.email = email
    }
}
