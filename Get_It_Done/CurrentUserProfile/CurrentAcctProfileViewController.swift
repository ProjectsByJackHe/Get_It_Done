//
//  CurrentProfileViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit
import Alamofire

class CurrentAcctProfileViewController: UIViewController, UITextFieldDelegate {

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveChangesButton(_ sender: UIButton) {
        struct User: Encodable {
            let name: String
            let email: String
            let skill1: String
            let skill2: String
            let skill3: String
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+token!,
            "Accept": "application/json"
        ]
        
        let user = User(name: newName.text ?? "", email: newEmail.text ?? "", skill1: newSkill1.text ?? "", skill2: newSkill2.text ?? "", skill3: newSkill3.text ?? "");
        
        AF.request(hostname+"/auth/edit",
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseJSON {response in
                        let alert = UIAlertController(title: "Saved", message: "saved", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
                        self.present(alert, animated: true, completion: nil)
                        print("saved")
        };
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
            self.curRepPoints.text = json["points"] as! String
            self.newEmail.text = json["email"] as! String
            self.newSkill1.text = json["skill1"] as! String
            self.newSkill2.text = json["skill2"] as! String
            self.newSkill3.text = json["skill3"] as! String
            self.newLocation.text = "Vancouver, BC"
            self.newName.text = self.curName.text
            
        }
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
