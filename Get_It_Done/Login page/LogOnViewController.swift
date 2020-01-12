//
//  LogOnViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit
import Alamofire

class LogOnViewController: UIViewController {
    
    @IBOutlet weak var emailAddressInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    let hostname = "https://api.getitdonetoday.online";
    let defaults = UserDefaults.standard
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func LogInButton(_ sender: UIButton) {
        print("login")
        guard let email = emailAddressInput.text else {return}
        guard let password = passwordInput.text else {return}
        
        // check to see if user credentials match the data in the database
        // if yes, navigate to the home screen
        // if not, stay on the screen and alert
        struct Login: Encodable {
            let email: String
            let password: String
        }
        
        let login = Login(email: email, password: password);
        
        AF.request(hostname+"/auth/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).responseJSON
            {response in
                    guard let json = response.value as? [String: Any] else {return}
                
                if json["message"] != nil {
                    // print(json["message"])
                    // log in failed
                    let alert = UIAlertController(title: "Error", message: "Wrong password", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
                    self.present(alert, animated: true, completion: nil)
                    print("wrong password")
                }
                else {
                    // print(json["token"])
                    // log in successful
                    self.defaults.set(json["token"], forKey: "isLogged")
                    self.performSegue(withIdentifier: "goHome", sender: self)
                }
        };
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        print("sign up")
        // print(self.defaults.url(forKey: "isLogged"))
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
