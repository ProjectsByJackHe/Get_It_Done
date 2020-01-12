//
//  CurrentProfileViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit

class CurrentAcctProfileViewController: UIViewController {

    @IBOutlet weak var curName: UILabel!
    @IBOutlet weak var curRepPoints: UILabel!
    
    
    @IBOutlet weak var newName: UITextField!
    
    @IBOutlet weak var newEmail: UITextField!
    
    @IBOutlet weak var newLocation: UITextField!
    
    @IBOutlet weak var newSkill1: UITextField!
    
    @IBOutlet weak var newSkill2: UITextField!
    
    @IBOutlet weak var newSkill3: UITextField!
    
    let currentUserToken = UserDefaults.standard.url(forKey: "isLogged")
    
    
    @IBAction func saveChangesButton(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get current user name, email, and skills from database
        
        
        
        
        
        newLocation.text = "Vancouver BC"
        newName.text = curName.text
        // newEmail.text = ... whatever email we have in the database
        
        // Do any additional setup after loading the view.
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
