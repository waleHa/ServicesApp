//
//  EditProfileViewController.swift
//  Flash Chat iOS13
//
//  Created by admin on 2021-01-02.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class MyProfileViewController: UIViewController {
    // MARK:-Outlets
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var address1Textfield: UITextField!
    @IBOutlet weak var address2Textfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var provinceNameTextfield: UITextField!
    @IBOutlet weak var zipCodeTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var phoneNoTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var updateWidthConstraint: NSLayoutConstraint!
    
    
    // MARK:- Variables

    var userCollectionRef: CollectionReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if( !Constants.User.changed ){
        if (Constants.User.UID.count <= 1){
        Constants.User.UID = (Auth.auth().currentUser?.uid ?? "") as String
            Constants.User.changed = true
        }}
 
        self.userCollectionRef = Firestore.firestore().collection(Constants.Firebase.USERS)
        
        userCollectionRef.whereField(Constants.Firebase.UID, isEqualTo: Constants.User.UID).getDocuments(completion: { (snapshot, e) in
            if let error = e{
                debugPrint("Error fetching docs: \(error.localizedDescription)")
            }
            else{
                guard let snap = snapshot else {return}
                for document in (snap.documents){
                        let data = document.data()
                        print(data)
                        self.firstNameTextfield.text = data[Constants.Firebase.firstName] as? String
                        self.lastNameTextfield.text = data[Constants.Firebase.lastName] as? String
                        self.phoneNoTextfield.text = data[Constants.Firebase.phoneNumber] as? String
                        let fullAddress = data[Constants.Firebase.fullAddress] as? Dictionary<String, String>
                        
                        self.provinceNameTextfield.text = fullAddress?[Constants.Firebase.province]
                        self.zipCodeTextfield.text = fullAddress?[Constants.Firebase.zipCode]
                        self.countryTextfield.text = fullAddress?[Constants.Firebase.country]
                        self.cityTextfield.text = fullAddress?[Constants.Firebase.city]
                        self.address1Textfield.text = fullAddress?[Constants.Firebase.address1]
                        self.address2Textfield.text = fullAddress?[Constants.Firebase.address2]
                        self.emailTextfield.text = Auth.auth().currentUser?.email
                }
            }
        })

        styleHollowButton(EditButton)
        
        Utilities.styleFilledButton(updateButton, withCornerSize:10);
        // Do any additional setup after loading the view.
        
//        print(type(of: userCollectionRef))
//        print("WAWA:MyProfile: \(Constants.User.UID)")
    }
    
    @IBAction func UpdateButtonPressed(_ sender: Any) {
        print("WAWA:UpdateButtonPressed")
 
        
        if(self.updateButton.titleLabel?.text == "Are You Sure"){
                   userCollectionRef.document(Constants.User.UID).updateData([
                    Constants.Firebase.phoneNumber:phoneNoTextfield.text!,
                    Constants.Firebase.firstName:firstNameTextfield.text!,
                    Constants.Firebase.lastName:lastNameTextfield.text!,
                    Constants.Firebase.fullAddress:[Constants.Firebase.address1:address1Textfield.text!, Constants.Firebase.address2:address2Textfield.text!, Constants.Firebase.city:cityTextfield.text!, Constants.Firebase.province:provinceNameTextfield.text!,  Constants.Firebase.zipCode:zipCodeTextfield.text!, Constants.Firebase.country:countryTextfield.text!]
]){ e in
                        if let error = e{
                            debugPrint("Error fetching docs: \(error.localizedDescription)")
                        }
                        else{
                            print("WAWA:Done")
                            Auth.auth().currentUser?.updateEmail(to: self.emailTextfield.text!, completion: { (e) in
                                if let error = e{
                                    debugPrint("Error fetching docs: \(error.localizedDescription)")
                                }
                                self.doneLabel.alpha = 1
                                self.doneLabel.text = "Updated Successfully"
                            })
                        }
                        
                    }
        }
        else{
            self.updateButton.setTitle("Are You Sure", for: .normal);
            Utilities.styleFilledButton(updateButton, withCornerSize:10,color: .red);
        }
        
//        var x = self.updateButton.titleLabel?.text!
//        print("myX:\(x)")
        self.updateWidthConstraint.constant = CGFloat((self.updateButton.currentTitle?.count)! * 15)
        
    }
    @IBAction func EditButtonPressed(_ sender: Any) {
    
    }
    func styleHollowButton(_ button:UIButton) {
        button.layer.borderWidth = 1;
        button.layer.borderColor = UIColor.white.cgColor;
        button.layer.cornerRadius = 10.0;
        button.tintColor = UIColor.white;
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
