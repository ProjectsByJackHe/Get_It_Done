//
//  CurrentProfileViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit
import Alamofire

class CurrentAcctProfileViewController: UIViewController {

    @IBOutlet weak var curName: UILabel!
    @IBOutlet weak var curRepPoints: UILabel!
    
    @IBOutlet weak var newName: UITextField!
    
    @IBOutlet weak var newEmail: UITextField!
    
    @IBOutlet weak var newLocation: UITextField!
    
    @IBOutlet weak var newSkill1: UITextField!
    
    @IBOutlet weak var newSkill2: UITextField!
    
    @IBOutlet weak var newSkill3: UITextField!
    
    let hostname = "https://api.getitdonetoday.online";
    
    let token = UserDefaults.standard.string(forKey: "isLogged")
    
    
    @IBAction func saveChangesButton(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get current user name, email, and skills from database
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+token!,
            "Accept": "application/json"
        ]
        AF.request(hostname+"/auth/me", headers: headers).responseJSON{response in
            guard let json = response.value as? [String: Any] else {return}
            self.curName.text = json["name"] as! String
            self.newEmail.text = json["email"] as! String
            self.newSkill1.text = json["skill1"] as! String
            self.newSkill2.text = json["skill2"] as! String
            self.newSkill3.text = json["skill3"] as! String
            self.newLocation.text = "Vancouver, BC"
            self.newName.text = self.curName.text
            
        }
        
        
        
        
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
