//
//  CreateAcctViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit
import Alamofire

class CreateAcctViewController: UIViewController {
    
    @IBOutlet weak var fullNameInput: UITextField!
    @IBOutlet weak var emailAddressInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    let hostname = "https://api.getitdonetoday.online";
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        guard let fullName = fullNameInput.text else {return}
        guard let emailAddress = emailAddressInput.text else {return}
        guard let password = passwordInput.text else {return}
        
        struct Login: Encodable {
            let name: String
            let email: String
            let password: String
        }
        
        let login = Login(name: fullName, email: emailAddress, password: password);
        
        AF.request(hostname+"/auth/register",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).responseJSON {response in
                    guard let json = response.value as? [String: Any] else {return}
                    
                    if json["message"] != nil {
                        // print(json["message"])
                        // log in failed
                        let alert = UIAlertController(title: "Error", message: "could not create account", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
                        self.present(alert, animated: true, completion: nil)
                        print("could not create account")
                    }
                    else {
                        // print(json["token"])
                        // log in successful
                        UserDefaults.standard.set(json["token"], forKey: "isLogged")
//                        self.performSegue(withIdentifier: "goHome", sender: self)
                        let alert = UIAlertController(title: "Success", message: "Account created", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
                        self.present(alert, animated: true, completion: nil)
                        print("created account")
                    }
        };
        
        // alert that an account is made and go back
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
