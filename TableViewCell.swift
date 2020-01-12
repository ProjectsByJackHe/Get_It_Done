//
//  TableViewCell.swift
//  Get_It_Done
//
//  Created by Jack He on 1/12/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var repPoints: UILabel!
    
    func setProfile(person:Profile){
        self.name.text = person.name
        self.repPoints.text = person.repPoints
    }
}
