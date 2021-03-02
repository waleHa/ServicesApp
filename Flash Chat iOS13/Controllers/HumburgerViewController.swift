//
//  HumburgerViewController.swift
//  EService
//
//  Created by admin on 2021-01-12.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
//protocol menuViewControllerDelegate {
//    func hideHamburgerMenu()
//}
class HumburgerViewController: UIViewController, UIGestureRecognizerDelegate {
//    var delegate : menuViewControllerDelegate?

    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var myprofileButton: UIButton!
    @IBOutlet weak var myservicesButton: UIButton!
    @IBOutlet weak var contactusButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var PicView: UIView!
    
//    let myProfileView : UIStoryboard = UIStoryboard(name: "MyProfileViewController", bundle:nil)
//    let myProfileView = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
//    let myProfileBoard : UIStoryboard = UIStoryboard(name: "myProfileStoryboard", bundle:nil)
//    let myProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! MyProfileViewController
//    self.navigationController?.pushViewController(VC, animated: true)
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupHamburgerUI()
        homeButton?.contentHorizontalAlignment = .left
        myprofileButton?.contentHorizontalAlignment = .left
        myservicesButton?.contentHorizontalAlignment = .left
        contactusButton?.contentHorizontalAlignment = .left
        logoutButton?.contentHorizontalAlignment = .left
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        PicView.addGestureRecognizer(tap)
    }
        @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myProfileVC = storyboard.instantiateViewController(identifier: "MyProfileViewController")
            show(myProfileVC, sender: self)
        }
    

    
    func setupHamburgerUI(){
        self.mainBackgroundView.layer.cornerRadius = 30
        self.mainBackgroundView.clipsToBounds = true
        self.profileImage.layer.cornerRadius = 40
        self.profileImage.clipsToBounds = true
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let mainVC = storyboard.instantiateViewController(identifier: "MainViewController")
    show(mainVC, sender: self)
    }
    
    @IBAction func myProfileButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myProfileVC = storyboard.instantiateViewController(identifier: "MyProfileViewController")
        show(myProfileVC, sender: self)
    }
    
    @IBAction func myServiceButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myServiceVC = storyboard.instantiateViewController(identifier: "MyServicesViewController")
        show(myServiceVC, sender: self)
        
    }
    @IBAction func contactUsButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactUsVC = storyboard.instantiateViewController(identifier: "ContactUsViewController")
        show(contactUsVC, sender: self)
    }
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            //To  take the screen to the root
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let logOutVC = storyboard.instantiateViewController(identifier: "WelcomeViewController")
                show(logOutVC, sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
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
//https://github.com/kashyapbhatt/iOSHamburgerMenu
