//
//  HomeViewController.swift
//  Get_It_Done
//
//  Created by Jack He on 1/11/20.
//  Copyright © 2020 Jack He Productions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var profiles:[Profile] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profiles = generateAllUsers()
        // Do any additional setup after loading the view.
    }
    
    func generateAllUsers() -> [Profile]{
        var tempProfiles:[Profile] = []
        let person1 = Profile(name: "Jacky Zhao", repPoints: "69")
        let person2 = Profile(name: "Gregor Kiczales", repPoints: "300")
        let person3 = Profile(name: "Patrice Belleview", repPoints: "250")
        tempProfiles.append(person1)
        tempProfiles.append(person2)
        tempProfiles.append(person3)
        
        return tempProfiles
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
