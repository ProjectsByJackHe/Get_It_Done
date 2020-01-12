//
//  HomeViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var profiles:[Profile] = []
    let hostname = "https://api.getitdonetoday.online";
    let token = UserDefaults.standard.string(forKey: "isLogged")
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        profiles = generateAllUsers()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        profiles = [];
        generateAllUsers()
    }
    
    func generateAllUsers() -> Void {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+token!,
            "Accept": "application/json"
        ]
        AF.request(hostname+"/job/list",
            headers: headers).responseJSON {response in
                guard let json = response.value as? [[String: Any]] else {return}
                for user in json {

                    let prof = Profile(name: user["name"] as! String, repPoints: user["points"] as! String, skill1: user["skill1"] as! String, skill2: user["skill2"] as! String, skill3: user["skill3"] as! String, email: user["email"] as! String)
                    self.profiles.append(prof)
                    self.tableView.reloadData()
                    debugPrint(self.profiles)
                }
        };
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile = profiles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! TableViewCell
        cell.setProfile(person: profile)
        return cell
    }
    
    var currentIndex:Int = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        performSegue(withIdentifier: "goToProfile", sender: self)
    }
    
    
    @IBAction func settingsButtonPushed(_ sender: UIButton) {
            let alert = UIAlertController(title: "Settings", message: "default settings configurations", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
            self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func showNotifications(_ sender: UIButton) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+token!,
            "Accept": "application/json"
        ]
        AF.request(hostname+"/auth/getrequests",
            headers: headers).responseJSON {response in
                guard let json = response.value as? [[String: Any]] else {return}
                debugPrint(json.count)
                let alert = UIAlertController(title: "Job notifications", message: "You currently have "+String(json.count)+" notifications.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
                self.present(alert, animated: true, completion: nil)

        };
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? UserProfileViewController else{return}
        vc.tmpName = profiles[currentIndex].name
        vc.tmpRep = profiles[currentIndex].repPoints
        vc.tmpSkill1 = profiles[currentIndex].skill1
        vc.tmpSkill2 = profiles[currentIndex].skill2
        vc.tmpSkill3 = profiles[currentIndex].skill3
        vc.tmpEmail = profiles[currentIndex].email
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
