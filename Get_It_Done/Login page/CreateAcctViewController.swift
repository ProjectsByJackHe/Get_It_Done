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
                   encoder: JSONParameterEncoder.default).response {response in debugPrint(response)};
        
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
