//
//  MainViewController.swift
//  EService
//
//  Created by admin on 2021-01-06.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class MainViewController: UIViewController {
    // MARK:-Outlets
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var leadingConstraintForHamburgerView: NSLayoutConstraint!
    
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var typeTextfield: UITextField!
    
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var provinceTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var zipCodefield: UITextField!
    @IBOutlet weak var locationButton: UIBarButtonItem!
    
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK:- Variables
    var categoryPickerData = [String]()
    var typePickerData = [String]()
    var countryPickerData = [String]()
    var cityPickerData = [String]()
    var provincePickerData = [String]()
    var locationManager = CLLocationManager()
    var countryPlacemarkString=String()
    var cityPlacemarkString=String()
    var provincePlacemarkString=String()
    var zipCodePlacemarkString = String()
    
    let pickerOfCategory = UIPickerView()
    let pickerOfType = UIPickerView()
    
    let pickerOfCountry = UIPickerView()
    let pickerOfProvince = UIPickerView()
    let pickerOfCity = UIPickerView()
    let pickerOfZipCode = UIPickerView()
    
    var categoriesCollectionRef: CollectionReference!
    var typesCollectionRef: CollectionReference!
    var countriesCollectionRef: CollectionReference!
    var provincesCollectionRef: CollectionReference!
    var citiesCollectionRef: CollectionReference!
    var zipCodeManager = ZipCodeManager()
    
    // MARK:-Actions
    @IBAction func CountryTextfieldPressed(_ sender: UITextField) {
        if let x = countryTextfield.text{
            provincePickerData.removeAll();
            if countryTextfield.text != ""{
                provincesCollectionRef = Firestore.firestore().collection(Constants.Firebase.COUNTRIES).document(x).collection("Provinces")
                collectionSetter(collectionRef: provincesCollectionRef, caller: "provinces")
            }
        }
    }
    @IBAction func provinceTextfieldPressed(_ sender: UITextField) {
        if let x = countryTextfield.text{
            if let y = provinceTextfield.text{
                cityPickerData.removeAll();
                if provinceTextfield.text != ""{
                    citiesCollectionRef = Firestore.firestore().collection(Constants.Firebase.COUNTRIES).document(x).collection("Provinces").document(y).collection("Cities")
                    collectionSetter(collectionRef: citiesCollectionRef, caller: "cities")
                }}
        }
    }
    @IBAction func categoryTextfieldPressed(_ sender: UITextField) {
        if let x = categoryTextfield.text{
            typePickerData.removeAll();
            if categoryTextfield.text != ""{
                typesCollectionRef = Firestore.firestore().collection(Constants.Firebase.CATEGORIES).document(x).collection(x)
                collectionSetter(collectionRef: typesCollectionRef, caller: "types")
            }
        }}
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        zipCodefield.endEditing(true)
    }
    @IBAction func didOpenMenu(_ sender: UIButton) {
        hideOrShow();
    }
    
    @IBAction func locationButtonPressed(_ sender: UIBarButtonItem) {
        countryTextfield.text = countryPlacemarkString
        cityTextfield.text = cityPlacemarkString
        provinceTextfield.text = provincePlacemarkString
        zipCodefield.text = zipCodePlacemarkString
        
    }
    
    // MARK:- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        menuView.isHidden = true;
        backView.isHidden = true;
        
        zipCodeManager.delegate = self;
        Utilities.styleFilledButton(searchButton, withCornerSize: 15, color: UIColor.init(red: 218/255, green: 242/255, blue: 254/255, alpha: 1));
        pickerOfCategory.tag = 1
        pickerOfType.tag = 2
        pickerOfCountry.tag = 11
        pickerOfProvince.tag = 12
        pickerOfCity.tag = 13
        pickerOfZipCode.tag = 14
        
        pickerSetter(for: categoryTextfield, toBe: pickerOfCategory);
        pickerSetter(for: typeTextfield, toBe: pickerOfType);
        pickerSetter(for: countryTextfield, toBe: pickerOfCountry);
        pickerSetter(for: provinceTextfield, toBe: pickerOfProvince);
        pickerSetter(for: cityTextfield, toBe: pickerOfCity);
        //        pickerSetter(for: zipCodefield, toBe: pickerOfZipCode);
        
        categoriesCollectionRef = Firestore.firestore().collection(Constants.Firebase.CATEGORIES)
        countriesCollectionRef = Firestore.firestore().collection(Constants.Firebase.COUNTRIES)
        

        
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        backView.addGestureRecognizer(tap)
        zipCodefield.delegate = self;
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation()
    }
    
    // MARK:- View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        collectionSetter(collectionRef: categoriesCollectionRef, caller: "categories");
        collectionSetter(collectionRef: countriesCollectionRef, caller: "countries");
        print("WAL: \(countryPickerData)");
    }
    
    
    
    // MARK:-  Functions:
    
    // MARK: hideOrShow Function
    func hideOrShow() {
        UIView.animate(withDuration: 0.3) {
            self.leadingConstraintForHamburgerView.constant = 10
            self.view.layoutIfNeeded()
            if (self.backView.isHidden){
                self.backView.alpha = 0.75}
            else{self.backView.alpha = 0.1}
            self.backView.isHidden = !self.backView.isHidden
        }
        UIView.animate(withDuration: 0.3) {
            self.leadingConstraintForHamburgerView.constant = 0
            self.view.layoutIfNeeded()
        }
        self.menuView.isHidden = !self.menuView.isHidden;
    }
    // MARK: Picker Fuctionality Setter
    func pickerSetter(for textfield:UITextField,toBe picker:UIPickerView){
        picker.delegate   = self
        picker.dataSource = self
        textfield.inputView = picker
    }
    // MARK: Google Cloud Firestore collections Setter
    func collectionSetter(collectionRef:CollectionReference!, caller:String){
        collectionRef.getDocuments { (snapshot, e) in
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
                        print(c)
                        if (caller == "categories"){
                            self.categoryPickerData.append(c)
                        }
                        else if (caller == "countries"){
                            self.countryPickerData.append(c)
                        }
                        else if (caller == "types"){
                            self.typePickerData.append(c)
                        }
                        else if (caller == "provinces"){
                            self.provincePickerData.append(c)
                        }
                        else if (caller == "cities"){
                            self.cityPickerData.append(c)
                        }
                        counter += 1
                    }}}
        }
    }
    
}
// MARK: Looker func for returnning a string index in a String Array
func looker(PickerData:[String],myString:String)->Int?{
    var counter = 0;
    for x in PickerData{
        if myString == x{
            print(counter)
            return counter
        }
        counter += 1
    }
    return nil;
}
// MARK:- UIPickerView Delegation
extension  MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 2){
            if( categoryTextfield.text! != "") {
                return typePickerData.count
            }
        }
        else if (pickerView.tag == 1){
            return categoryPickerData.count
        }
        else if (pickerView.tag == 11){
            return countryPickerData.count
        }
        else if (pickerView.tag == 12){
            if( countryTextfield.text! != "") {
                return provincePickerData.count
            }
        }
        else if (pickerView.tag == 13){
            if( provinceTextfield.text! != "") {
                return cityPickerData.count
            }
        }
        return 1;
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2{
            if( categoryTextfield.text! != "") {
                return typePickerData[row]
            }
            return "Please, Fill Category First"
        }
        else if (pickerView.tag == 1){
            return self.categoryPickerData[row]
        }
        else if(pickerView.tag == 11){
            return self.countryPickerData[row]
        }
        else if pickerView.tag == 12{
            if( countryTextfield.text! != "") {
                return provincePickerData[row]
            }
            return "Please, Fill Country First"
        }
        else if pickerView.tag == 13{
            if( provinceTextfield.text! != "") {
                return cityPickerData[row]
            }
            return "Please, Fill Province First"
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
        else if pickerView.tag == 1{
            categoryTextfield.text = categoryPickerData[row];
            typeTextfield.text = ""
            self.categoryTextfield.endEditing(true);
        }
        else if pickerView.tag == 11{
            countryTextfield.text = countryPickerData[row];
            typeTextfield.text = ""
            self.countryTextfield.endEditing(true);
        }
        else if pickerView.tag == 12{
            if( countryTextfield.text! != "") {
                provinceTextfield.text = provincePickerData[row]
            }
            self.provinceTextfield.endEditing(true);
        }
        else if pickerView.tag == 13{
            if( provinceTextfield.text! != "") {
                self.cityTextfield.text = cityPickerData[row]
            }
            self.cityTextfield.endEditing(true);
        }
    }
    
}

extension  MainViewController: UIGestureRecognizerDelegate  {
    // MARK:- HandleTap
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        hideOrShow();
    }
}
//
extension  MainViewController: UITextFieldDelegate {
    // MARK:- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zipCodefield.endEditing(true)
        return true
    }
    //Validation
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else{
            textField.placeholder = "Place your Postal Code Here"
            return false;
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let zipCode = zipCodefield.text{
            zipCodeManager.fetchZipCode(code: zipCode)
        }
    }
}
// MARK:- Zip Code Delegate for zipCode API https://www.zip-codes.com/zip-code-api.asp
extension  MainViewController: ZipCodeDelegate {
    func didUpdateAddressByZipCode(_ ZipCode: ZipCodeManager, address:AddressModel){
        //        print(address.city)
        DispatchQueue.main.async {
            self.cityTextfield.text = address.city
            self.countryTextfield.text = address.country
            self.provinceTextfield.text = address.province
        }
    }
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}
// MARK:- CLLocationManagerDelegate
extension  MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last{let lat = location.coordinate.latitude}
        lookUpCurrentLocation(location: locations.last) { (placemark) in
//            print("ZipCode:\(placemark?.postalCode)")
            
            if let country = placemark?.country{
                self.countryPlacemarkString = country
                let p:String? = Utilities.provinceNamesConverter(shortName: (placemark?.administrativeArea!)!)
                    if let province = p {
                        self.provincePlacemarkString = province
                            if let city = placemark?.locality{
                                self.cityPlacemarkString = city
                                
                                if let zipCode = placemark?.postalCode{
                                    self.zipCodePlacemarkString = zipCode}
                        }
                }
            }
                
//            if let row = looker(PickerData: self.countryPickerData, myString: self.countryPlacemark){
//            self.pickerOfCountry.selectRow(row, inComponent: 0, animated: true)
//                    print(row)
//                self.countryTextfield.text = self.countryPlacemark;
//                self.pickerOfCountry.reloadAllComponents();
//                print("PickerData:\(self.countryPickerData)")
////                    self.provincePickerData.removeAll();
//                    if self.countryTextfield.text != ""{
//                        self.provincesCollectionRef = Firestore.firestore().collection(Constants.Firebase.COUNTRIES).document(self.countryPlacemark).collection("Provinces")
//                        self.collectionSetter(collectionRef: self.provincesCollectionRef, caller: "provinces")
//
//                                        self.provinceTextfield.text = self.provincePlacemark;
////                                        print("PickerData:\(self.provincePickerData)")
//                                        if let row = looker(PickerData: self.provincePickerData, myString: self.provincePlacemark){
//                                    self.pickerOfProvince.selectRow(row, inComponent: 0, animated: true)
//                                        self.pickerOfProvince.reloadAllComponents();
//                                            print("PickerData:\(self.provincePickerData)")
//
//                                            if self.provinceTextfield.text != ""{
//                                                self.citiesCollectionRef = Firestore.firestore().collection(Constants.Firebase.COUNTRIES).document(self.countryPlacemark).collection("Provinces").document(self.provincePlacemark).collection("Cities")
//                                                self.collectionSetter(collectionRef: self.citiesCollectionRef, caller: "cities")
//                                            }
//                    }
//                }}
            
            
//            let p:String? = Utilities.provinceNamesConverter(shortName: (placemark?.administrativeArea!)!)
//            if let province = p {
//                self.provinceTextfield.text = province;
//                print("PickerData:\(self.provincePickerData)")
//                if let row = self.looker(PickerData: self.provincePickerData, myString: province){
//            self.pickerOfProvince.selectRow(row, inComponent: 0, animated: true)
//                self.pickerOfProvince.reloadAllComponents();
////                    if let x = self.countryTextfield.text, let y = self.provinceTextfield.text{
//////                    self.cityPickerData.removeAll();
//////                        self.provincePickerData.removeAll();
////
////                    if self.provinceTextfield.text != ""{
////                        self.citiesCollectionRef = Firestore.firestore().collection(Constants.Firebase.COUNTRIES).document(x).collection("Provinces").document(y).collection("Cities")
////                        self.collectionSetter(collectionRef: self.citiesCollectionRef, caller: "cities")
////                    }
////                        }
//                }}
//
//            if let city = placemark?.locality{
//            self.cityTextfield.text = city;
//                print("PickerData:\(self.cityPickerData)")
//            if let row = self.looker(PickerData: self.cityPickerData, myString: city){
//                self.pickerOfCity.selectRow(row, inComponent: 0, animated: true)
//                self.pickerOfCity.reloadAllComponents();
//
//            }
//            }

//            self.cityTextfield.text = placemark?.locality!

        }
        }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
func lookUpCurrentLocation(location:CLLocation?, completionHandler: @escaping (CLPlacemark?) -> Void ) {
    // Use the last reported location.
    if let lastLocation = location {
        let geocoder = CLGeocoder()
            
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(lastLocation,
                    completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
             // An error occurred during geocoding.
                completionHandler(nil)
            }
        })
    }
    else {
        // No location was available.
        completionHandler(nil)
    }
}

}
