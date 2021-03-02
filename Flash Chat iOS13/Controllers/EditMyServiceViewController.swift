//
//  AddEditServiceViewController.swift
//  Flash Chat iOS13
//
//  Created by admin on 2021-01-02.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class EditMyServiceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    // MARK:-Outlets
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var typeTextfield: UITextField!
    // MARK:- Variables
    var categoryPickerData = [String]()
    var typePickerData = [String]()
    let pickerOfCategory = UIPickerView()
    let pickerOfType = UIPickerView()
    var categoriesCollectionRef: CollectionReference!
    var typesCollectionRef: CollectionReference!
    
    // MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        categoriesCollectionRef.getDocuments { (snapshot, e) in
            if let error = e{
                debugPrint("Error fetching docs: \(error.localizedDescription)")
            }
            else{
                guard let snap = snapshot else {return}
                var counter = 0
                for document in (snap.documents){
                    let data = document.data()
                    let catgory = data["name"] as? String
                    if let c = catgory{
                        self.categoryPickerData.append(c)
                    }
                    counter += 1
                }}}
    }
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerOfCategory.dataSource = self
        pickerOfCategory.delegate   = self
        pickerOfType.delegate   = self
        pickerOfType.dataSource = self
        categoriesCollectionRef = Firestore.firestore().collection(Constants.Firebase.CATEGORIES)
        self.typeTextfield.inputView = self.pickerOfType

        self.categoryTextfield.inputView = self.pickerOfCategory
        pickerOfCategory.tag = 1
        pickerOfType.tag = 2
//        self.typeTextfield.adjustsFontSizeToFitWidth = true;
//            self.typeTextfield.minimumFontSize = 10.0;
//        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
//        tap.delegate = self
//        typeTextfield.addGestureRecognizer(tap)
        
    }
    // MARK:- UIPickerView Delegation
//    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
//    }
    
    // MARK:- Actions
    @IBAction func categoryTextfieldPressed(_ sender: UITextField) {
        callTypes()
    }
    // MARK:- UIPickerView Delegation
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if (pickerView.tag == 2){
                if( categoryTextfield.text! != "") {
                return typePickerData.count
                }
                return 1;
            }
            else if (pickerView.tag == 1){
                return categoryPickerData.count
            }
            return 1;
            }
        func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
                if pickerView.tag == 2{
                    print(categoryTextfield.text!)
                    if( categoryTextfield.text! != "") {
                    return typePickerData[row]
                    }
                    else{
//                        typeTextfield.text = "Please, Fill Category First"
                        return "Please, Fill Category First"
//                        self.typeTextfield.endEditing(true);
                    }
                }
                else if (pickerView.tag == 1){
                    return self.categoryPickerData[row]
            }
            return "";
            }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            if pickerView.tag == 2{
            if( categoryTextfield.text! != "") {
                typeTextfield.text = typePickerData[row]
            }
            self.typeTextfield.endEditing(true);
            }
            if pickerView.tag == 1{
            categoryTextfield.text = categoryPickerData[row];
                typeTextfield.text = ""
            self.categoryTextfield.endEditing(true);
                
            }
        }
    // MARK:- TypesPicker Function
    func callTypes(){
var localTypesPickerData = [String]()
if (categoryTextfield.text! != ""){
    if let x = categoryTextfield.text{
            typesCollectionRef = Firestore.firestore().collection(Constants.Firebase.CATEGORIES).document(x).collection(x)
                    typesCollectionRef.getDocuments { (snapshot, e) in
                        if let error = e{
                            debugPrint("Error fetching docs: \(error.localizedDescription)")
                        }
                        else{
                            guard let snap = snapshot else {return}
                            for document in (snap.documents){
                                let data = document.data()
                                let catgory = data["name"] as? String
                                if let c = catgory{
                                localTypesPickerData.append(c)
                                }
                            }
                            self.typePickerData = localTypesPickerData
    }}
        
    }}}
}
