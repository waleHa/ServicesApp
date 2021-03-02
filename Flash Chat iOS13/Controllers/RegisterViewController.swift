//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController{
//MARK:- Fields
    @IBOutlet weak var labelfield: UILabel!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNamefield: UITextField!
    @IBOutlet weak var address1field: UITextField!
    @IBOutlet weak var address2field: UITextField!
    @IBOutlet weak var cityfield: UITextField!
    @IBOutlet weak var provinceTextfield: UITextField!
    @IBOutlet weak var zipCodeTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordConfirmationTextfield: UITextField!
//MARK:- Buttons

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!


    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
let views = [labelfield, firstNameTextfield, lastNamefield,address1field, address2field, cityfield, provinceTextfield, zipCodeTextfield,countryTextfield,phoneNumberTextfield,emailTextfield,passwordTextfield,passwordConfirmationTextfield];
                for x in views{
                    if (type(of: x!) == UITextField.self){
                        Utilities.styleTextField(x! as! UITextField)
                    }
                    else{
                        shapingRadius(the: x!);
                    }
                }
        Utilities.styleFilledButton(logInButton, withCornerSize:25)
        Utilities.styleHollowButton(registerButton, withCornerSize:25)
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        //Validate the Fields
        let error = validateFields()
        if error != nil{
            //There are are something wrong with the fields, show it
            showError(error!)
        }
        else{
            //Create cleaned versions of data
            let firstName = firstNameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let lastName = lastNamefield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let address1 = address1field.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let address2 = address2field.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let country = countryTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let province = provinceTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let city = cityfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let zipCode = zipCodeTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let phoneNumber = phoneNumberTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let email = emailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
            //Create the User
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let e = error{
                        self.showError("\(e.localizedDescription)")
                    }
                    else{ //if (error == nil){
                        let db = Firestore.firestore()
                        db.collection(Constants.Firebase.USERS).document(authResult!.user.uid).setData( [Constants.Firebase.UID:authResult!.user.uid, Constants.Firebase.firstName:firstName, Constants.Firebase.lastName:lastName, Constants.Firebase.fullAddress: [Constants.Firebase.address1:address1, Constants.Firebase.address2:address2, Constants.Firebase.city:city, Constants.Firebase.province:province,  Constants.Firebase.zipCode:zipCode, Constants.Firebase.country:country], Constants.Firebase.phoneNumber:phoneNumber, Constants.Firebase.isUserAProvider:false]) {(error) in
                            if let e = error{
                                self.showError("\(e.localizedDescription)");
                            }
                            else{ //if (error == nil){
                                Constants.User.UID = authResult!.user.uid;
                                print("WAWA:Register\(Constants.User.UID)")
                                self.labelfield.text = "User Added Successfully"
                                //Transition to the home screen
//                                let mainVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController)
//                                self.view.window?.rootViewController = mainVC
//                                self.view.window?.makeKeyAndVisible()
                                self.performSegue(withIdentifier: Constants.Segues.registerToMain, sender: self)
                            }
                        }
                        
                        
                    }
            }
        }
    }
    @IBAction func logInPressed(_ sender: UIButton) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let logOutVC = storyboard.instantiateViewController(identifier: "LoginViewController")
    show(logOutVC, sender: self)
    }

    func showError(_ message:String){
        self.labelfield.text = message
        self.labelfield.alpha = 1
    }
    func validateFields() -> String?{
        let cleanedPassword = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines);
        if (firstNameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        lastNamefield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordConfirmationTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordConfirmationTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        countryTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        provinceTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        cityfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        zipCodeTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        address1field.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//        address2field.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        phoneNumberTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
            return "Please, fill in all fields.";
        }
        else if( Utilities.isPasswordValid(cleanedPassword) == false){
            return "Please, make sure your password is at least 8 characters, contains a speacial character and a number."
        }
        else if (passwordTextfield.text! != passwordConfirmationTextfield.text!){
            return "Password fields are not the same!";
        }
        else{
        return nil
        }
    }
    
    
    func shapingRadius(the view:UIView){
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.tintColor = UIColor.white;
        view.layer.borderColor = UIColor.white.cgColor;
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.45);
    }

}
