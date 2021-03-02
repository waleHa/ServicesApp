//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordConfTextfield: UITextField!

    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var logIn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        self.navigationItem.setHidesBackButton(true, animated: true)
        Utilities.styleHollowButton(signIn, withCornerSize:25)
            Utilities.styleHollowButton(logIn, withCornerSize: 25)

    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let em = emailTextfield.text, let p = passwordTextfield.text{
            let email = em.trimmingCharacters(in: .whitespacesAndNewlines);
            let password = p.trimmingCharacters(in: .whitespacesAndNewlines);
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                       if let e = error{
                        self.errorLabel.text = e.localizedDescription
                        self.errorLabel.alpha = 1
                       }
                       else{
                        Constants.User.UID = authResult!.user.uid;
                        print("WAWA:LOGIN: \(Constants.User.UID)")
//                        self.labelfield.text = "User Added Successfully"
                           //self.labelfield.text = "User Added"
//                        let mainVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController)
//                        self.view.window?.rootViewController = mainVC
                        self.performSegue(withIdentifier: "LoginToMain", sender: self)
                        
                       }
               }
    
    }
    }
    @IBAction func registerPressed(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let logOutVC = storyboard.instantiateViewController(identifier: "RegisterViewController")
    show(logOutVC, sender: self)
    }
    
    
    
}
