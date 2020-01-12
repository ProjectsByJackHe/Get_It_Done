//
//  UserProfileViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    var tmpName:String = ""
    var tmpRep:String = ""
    var tmpEmail:String = ""
    var tmpSkill1:String = ""
    var tmpSkill2:String = ""
    var tmpSkill3:String = ""
    
    @IBOutlet weak var name: UILabel!
    
    // not involved in override func settings
    @IBOutlet weak var reputation: UILabel!
    
    @IBOutlet weak var curName: UILabel!
    @IBOutlet weak var curEmail: UILabel!
    
    
    @IBOutlet weak var skill1Display: UILabel!
    @IBOutlet weak var skill2Display: UILabel!
    @IBOutlet weak var skill3Display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.name.text = self.tmpName
        self.reputation.text = self.tmpRep
        self.curEmail.text = self.tmpEmail
        self.skill1Display.text = self.tmpSkill1
        self.skill2Display.text = self.tmpSkill2
        self.skill3Display.text = self.tmpSkill3
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
