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
        generateAllUsers()
//        profiles = generateAllUsers()
        // Do any additional setup after loading the view.
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

                    let prof = Profile(name: user["name"] as! String, repPoints: user["points"] as! String)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? UserProfileViewController else{return}
        vc.tmpName = profiles[currentIndex].name
        vc.tmpRep = profiles[currentIndex].repPoints
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
