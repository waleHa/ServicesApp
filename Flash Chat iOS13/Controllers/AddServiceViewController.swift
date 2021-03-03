


//
//  AddServiceViewController.swift
//  EService
//
//  Created by admin on 2021-01-19.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class AddServiceViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var shiftSetterView: UIView!
    @IBOutlet weak var finalStepView: UIView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var servicesView: UIView!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    @IBOutlet weak var startTimeBottomTextField: UITextField!
    @IBOutlet weak var endTimeBottomTextField: UITextField!
    @IBOutlet weak var shiftSetterMainLabel: UILabel!
    @IBOutlet weak var shiftSetterDayLabel: UILabel!
    @IBOutlet weak var areUDoneLabel: UILabel!

    @IBOutlet weak var mondaySwitch: UISwitch!
    @IBOutlet weak var tuesdaySwitch: UISwitch!
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    @IBOutlet weak var thursdaySwitch: UISwitch!
    @IBOutlet weak var fridaySwitch: UISwitch!
    @IBOutlet weak var saturdaySwitch: UISwitch!
    @IBOutlet weak var sundaySwitch: UISwitch!
    
    @IBOutlet weak var saveShift: UIButton!
    @IBOutlet weak var saveTheService: UIButton!
    
    @IBOutlet weak var mondayAddButton: UIButton!
    @IBOutlet weak var tuesdayAddButton: UIButton!
    @IBOutlet weak var wednesdayAddButton: UIButton!
    @IBOutlet weak var thursdayAddButton: UIButton!
    @IBOutlet weak var fridayAddButton: UIButton!
    @IBOutlet weak var saturdayAddButton: UIButton!
    @IBOutlet weak var sundayAddButton: UIButton!
    
    @IBOutlet weak var mondayEditButton: UIButton!
    @IBOutlet weak var tuesdayEditButton: UIButton!
    @IBOutlet weak var wednesdayEditButton: UIButton!
    @IBOutlet weak var thursdayEditButton: UIButton!
    @IBOutlet weak var fridayEditButton: UIButton!
    @IBOutlet weak var saturdayEditButton: UIButton!
    @IBOutlet weak var sundayEditButton: UIButton!
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!


//MARK:- Variables
    var isBottomSheetShown = false;
    var currentShiftAndDay=String()
    let myServicesViewController = MyServicesViewController()
//    var myLovelyDay:String = ""
    var finished = [String]()
    var finishedCounter = 0
    var service : Service!
    var isServiceAvailable = false
    var userCollectionRef: DocumentReference!
    var serviceCollectionRef: CollectionReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        self.addBarButtonItem.isEnabled = false
        self.navigationItem.rightBarButtonItem = nil
        alpahToZero(the: servicesView,collectionView,areUDoneLabel,shiftSetterView,saveTheService,mondayAddButton,tuesdayAddButton,wednesdayAddButton,thursdayAddButton,fridayAddButton,saturdayAddButton,sundayAddButton,mondayEditButton,tuesdayEditButton,wednesdayEditButton,thursdayEditButton,fridayEditButton,saturdayEditButton,sundayEditButton);

        shapingRadius(the: saveShift,shiftSetterView,servicesView,saveTheService,daysCollectionView);
        
        service = Service(category: categoryTextField.text!, type: typeTextField.text!, country: countryTextField.text!, city: cityTextField.text!, province: provinceTextField.text!, address1: address1TextField.text!, address2: address2TextField.text!,zipCode: zipCodeTextField.text!, status: true)
    }
    
    //MARK:- A Toggle UISwitch Pressed
        @IBAction func mondaySwitchPressed(_ sender: UISwitch) {
            let day = "Monday"
            //hide or show days
            alpahReversing(the:mondayAddButton);
            if (mondayAddButton.alpha == 0){
                alpahToZero(the:mondayEditButton);
                service.days[day] = false;
                if let num = looker(PickerData: finished, myString: day){
                    finished.remove(at: num)
                }
                reloadDaysCollection();
            }}
        @IBAction func tuesdaySwitchPressed(_ sender: UISwitch) {
            let day = "Tuesday"
            alpahReversing(the:tuesdayAddButton);
            if (tuesdayAddButton.alpha == 0){
                alpahToZero(the:tuesdayEditButton);
                service.days[day] = false;
                if let num = looker(PickerData: finished, myString: day){
                    finished.remove(at: num)
                }
                reloadDaysCollection();
            }}
        @IBAction func wednesdaySwitchPressed(_ sender: UISwitch) {
            let day = "Wednesday"
                alpahReversing(the:wednesdayAddButton);
            if (wednesdayAddButton.alpha == 0){
                alpahToZero(the:wednesdayEditButton);
                service.days[day] = false;
                if let num = looker(PickerData: finished, myString: day){
                    finished.remove(at: num)
                }
                reloadDaysCollection();
            }}
        @IBAction func thursdaySwitchPressed(_ sender: UISwitch) {
            let day = "Thursday"
            alpahReversing(the:thursdayAddButton);
            if (thursdayAddButton.alpha == 0){
                alpahToZero(the:thursdayEditButton);
                service.days[day] = false;
                if let num = looker(PickerData: finished, myString: day){
                    finished.remove(at: num)
                }
                reloadDaysCollection();
            }}
        @IBAction func fridaySwitchPressed(_ sender: UISwitch) {
            let day = "Friday"
                    alpahReversing(the:fridayAddButton)
                if (fridayAddButton.alpha == 0){
                    alpahToZero(the:fridayEditButton);
                    service.days[day] = false;
                    if let num = looker(PickerData: finished, myString: day){
                        finished.remove(at: num)
                    }
                    reloadDaysCollection();
            }}
        @IBAction func saturdaySwitchPressed(_ sender: UISwitch) {
            let day = "Saturday"
            alpahReversing(the:saturdayAddButton);
            if (saturdayAddButton.alpha == 0){
                alpahToZero(the:saturdayEditButton);
                service.days[day] = false;
                if let num = looker(PickerData: finished, myString: day){
                    finished.remove(at: num)
                }
                reloadDaysCollection();
            }}
        @IBAction func sundaySwitchPressed(_ sender: UISwitch) {
            let day = "Sunday"
            alpahReversing(the:sundayAddButton);
            if (sundayAddButton.alpha == 0){
                alpahToZero(the:sundayEditButton);
                service.days[day] = false;
                if let num = looker(PickerData: finished, myString: day){
                    finished.remove(at: num)
                }
                reloadDaysCollection();
            }}
    //MARK:- Save The Service Button Pressed
    @IBAction func saveTheServiceButtonPressed(_ sender: UIButton) {
       //MARK: Validating The Service (if No text)
        if (categoryTextField.text == "" ||
            typeTextField.text == "" ||
            countryTextField.text == "" ||
            cityTextField.text == "" ||
            provinceTextField.text == "" ||
            zipCodeTextField.text == ""){
            serviceValidator();
        }
        else{
            //if there is no days added
            if(service.availableDaysCount() == 0){
                  areUDoneLabel.text! = "Please, Add Some Days First"
            }
            else{
                service.category = categoryTextField.text!
                service.type = typeTextField.text!
                service.country = countryTextField.text!
                service.city = cityTextField.text!
                service.province = provinceTextField.text!
                service.zipCode = zipCodeTextField.text!
                service.status = true
                
//                x.append(service);
                
//                    if(Constants.User.changed == false){
//                        if (Constants.User.UID.count <= 1){
//                        Constants.User.UID = (Auth.auth().currentUser?.uid ?? "") as String
//                            Constants.User.changed = true
//                        }}
                
                        self.serviceCollectionRef = Firestore.firestore().collection("\(Constants.Firebase.USERS)/\(Constants.User.UID)/Service/")
                
                          
                serviceCollectionRef.getDocuments { (snapshot, e) in
                    if let error = e{
                        debugPrint("Error fetching docs: \(error.localizedDescription)")
                    }
                    else{
                        guard let snap = snapshot else {return}
                        for document in (snap.documents){
//                            let data = document.data()
                            print(document.documentID)
                            if (document.documentID == "\(self.service.type)&\(self.service.city)"){
                                self.isServiceAvailable = true
                                print("if statement is here")
                            }
                        }
                        
                        
                        print("wa7a: \(self.isServiceAvailable)")

                        if (self.isServiceAvailable == true){
                            self.alpahToOne(the: self.areUDoneLabel,self.finalStepView)
                            self.areUDoneLabel.text = "service is already available"
                            self.isServiceAvailable = false
                        }
                        else
                        {
                            Firestore.firestore().document("/\(Constants.Firebase.USERS)/\(Constants.User.UID)/Service/\(self.service.type)&\(self.service.city)").setData([Constants.Firebase.category:self.service.category,Constants.Firebase.type:self.service.type, Constants.Firebase.fullAddress: [Constants.Firebase.address1:self.service.address1,Constants.Firebase.address2:self.service.address2,  Constants.Firebase.city:self.service.city, Constants.Firebase.province:self.service.province,  Constants.Firebase.zipCode:self.service.zipCode, Constants.Firebase.country:self.service.country],"days": self.service.days,"startEnd":self.service.startEnd])
                            
                            
// var days: [String : Bool] = ["Monday" : false, "Tuesday" : false, "Wednesday" : false, "Thursday" : false, "Friday" : false, "Saturday" : false, "Sunday" : false]
                            
// var startEnd : [String:[String?]] = ["Monday" : [nil, nil], "Tuesday" : [nil, nil],  "Wednesday" : [nil, nil],   "Thursday" : [nil, nil],  "Friday" : [nil, nil],   "Saturday" : [nil, nil],    "Sunday" : [nil, nil]]
                            //        service.days["Thursday1"] = true;
                            //    startEnd[Thursday]?[0] = "08:00 AM"
                            //    startEnd[Thursday]?[1] = "08:00 AM"
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let myServiceVC = storyboard.instantiateViewController(identifier: "MyServicesViewController")
                            self.show(myServiceVC, sender: self)
                        }
                        
                    }
                }

                    
                //Add a ref in the city
                        
                        
                        
                            
                            
//                        userCollectionRef.collection("Service").addDocument()
                        
                        
                        
                        
                        
                        hideShiftSettingView();
//                        self.performSegue(withIdentifier: Constants.Segues.registerToMain, sender: self)
                            
                }}}
                
                //                userCollectionRef.whereField(Constants.Firebase.UID, isEqualTo: Constants.User.UID).
                //                getDocuments
                //                (completion: { (snapshot, e) in
                //                if let error = e{
                //                    debugPrint("Error fetching docs: \(error.localizedDescription)")
                //                }
                //                else{
                //
                //                    }
                //                })
                
                
//                userCollectionRef.whereField(Constants.Firebase.UID, isEqualTo: Constants.User.UID).
//                getDocuments
//                (completion: { (snapshot, e) in
//                if let error = e{
//                    debugPrint("Error fetching docs: \(error.localizedDescription)")
//                }
//                else{
//
//                    }
//                })
                
                
                
//                let db = Firestore.firestore()

                
                
                //                db.collection(Constants.Firebase.USERS).document(authResult!.user.uid).setData( [Constants.Firebase.UID:authResult!.user.uid, Constants.Firebase.firstName:firstName, Constants.Firebase.lastName:lastName, Constants.Firebase.fullAddress: [Constants.Firebase.address1:address1, Constants.Firebase.address2:address2, Constants.Firebase.city:city, Constants.Firebase.province:province,  Constants.Firebase.zipCode:zipCode, Constants.Firebase.country:country], Constants.Firebase.phoneNumber:phoneNumber, Constants.Firebase.isUserAProvider:false]) {(error) in
//                    if let e = error{
//                        self.showError("\(e.localizedDescription)");
//                    }
//                    else{ //if (error == nil){
//                        Constants.User.UID = authResult!.user.uid;
//                        print("WAWA:Register\(Constants.User.UID)")
//                        self.labelfield.text = "User Added Successfully"}
//
//                }
                                                
                                                //Transition to the home screen
                //                                let mainVC = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController)
                //                                self.view.window?.rootViewController = mainVC
                //                                self.view.window?.makeKeyAndVisible()
                                               
                                            
                
                //MARK:****** To add going back here
                

    //MARK:- Save Buttons Pressed
    @IBAction func saveShiftPressed(_ sender: Any) {
        alpahToOne(the: areUDoneLabel,finalStepView)
        //Make sure all text field got filled
        if (categoryTextField.text == "" ||
        typeTextField.text == "" ||
        countryTextField.text == "" ||
        cityTextField.text == "" ||
        provinceTextField.text == "" ||
            zipCodeTextField.text == ""){
            serviceValidator();
        }
           //when all text field got filled
        else{
            //Make sure all times got added
            if(startTimeBottomTextField.text == "" || endTimeBottomTextField.text == ""){
                areUDoneLabel.text! = "Please, add start and end time!"
            }
                //when all text times are added
            else{
                alpahToOne(the: saveTheService)
                //Add Shift on a specifc day
                func daysTimingSetter(_ day:String){
               
                    service.days["\(day)"] = true
                    service.startEnd["\(day)"]?[0] = startTimeBottomTextField.text;
                    
                    service.startEnd["\(day)"]?[1] = endTimeBottomTextField.text;
                    
                    areUDoneLabel.text = " \(day):  \(service.startEnd["\(day)"]?[0] ?? "") - \(service.startEnd["\(day)"]?[1] ?? "")";
                   finishedCounter += 1;
                    finished.append(shiftSetterDayLabel.text!);
                          if (shiftSetterDayLabel.text == "Monday"){mondayEditButton.alpha = 1;}
                          else if(shiftSetterDayLabel.text == "Tuesday"){tuesdayEditButton.alpha = 1;}
                          else if(shiftSetterDayLabel.text == "Wednesday"){wednesdayEditButton.alpha = 1;}
                          else if(shiftSetterDayLabel.text == "Thursday"){thursdayEditButton.alpha = 1;}
                          else if(shiftSetterDayLabel.text == "Friday"){fridayEditButton.alpha = 1;}
                          else if(shiftSetterDayLabel.text == "Saturday"){saturdayEditButton.alpha = 1;}
                          else if(shiftSetterDayLabel.text == "Sunday"){sundayEditButton.alpha = 1;}
//                    areUDoneLabel.text = "Are you done?"
                    reloadDaysCollection();
                }
                daysTimingSetter(shiftSetterDayLabel.text!);
            ///*****************
                hideShiftSettingView();
                currentShiftAndDay = "\(shiftSetterDayLabel.text!): First Shift";
                alpahToOne(the: collectionView,servicesView)
            }}}
        
    
    //MARK: Validating The Service Func
    //Will add all the messing text fields
    func serviceValidator(){

         areUDoneLabel.text = "Please, Add: "
         var n = 0
         func addComma(){
                         if(n>0){
                                areUDoneLabel.text! += ", "
                            }
                        }
         if (categoryTextField.text == ""){
             areUDoneLabel.text! += "Category"
             n += 1;
         }
         if (typeTextField.text == ""){
            addComma();
            areUDoneLabel.text! += "Type"
             n += 1;
         }
          
         if(countryTextField.text == ""){
            addComma();
            areUDoneLabel.text! += "country"
             n += 1;
         }
         
         if(cityTextField.text == ""){
            addComma();
            areUDoneLabel.text! += "City"
             n += 1;
         }
         if(provinceTextField.text == ""){
            addComma();
            areUDoneLabel.text! += "Province"
             n += 1;
         }
         if(zipCodeTextField.text == ""){
            addComma();
            areUDoneLabel.text! += "ZipCode"
             n += 1;
         }}

    //MARK:- Add Buttons Pressed
    @IBAction func MondayAddButton(_ sender: Any) {
        shiftSetterDayLabel.text = "Monday"
        showShiftSettingView();
    }
    @IBAction func TuesdayAddButton(_ sender: Any) {
        shiftSetterDayLabel.text = "Tuesday";
        showShiftSettingView();
            }
    @IBAction func WednesdayAddButton(_ sender: Any) {
          shiftSetterDayLabel.text = "Wednesday";
        showShiftSettingView();
              }
    @IBAction func ThursdayAddButton(_ sender: Any) {
    shiftSetterDayLabel.text = "Thursday";
        showShiftSettingView();
    }
    @IBAction func FridayAddButton(_ sender: Any) {
    shiftSetterDayLabel.text = "Friday";
        showShiftSettingView();
    }
    @IBAction func SaturdayAddButton(_ sender: Any) {
    shiftSetterDayLabel.text = "Saturday";
        showShiftSettingView();
    }
    @IBAction func SundayAddButton(_ sender: Any) {
    shiftSetterDayLabel.text = "Sunday";
        showShiftSettingView();
    }
    //MARK:- helpful Functions
    func reloadDaysCollection(){
        DispatchQueue.main.async {
            var cellsCounter = self.service.availableDaysCount()
            var indexPath = IndexPath(row: cellsCounter, section: 0)
            if(cellsCounter > 0){
                indexPath = IndexPath(row: cellsCounter - 1, section: 0)
            }
                self.daysCollectionView.reloadData();
                self.daysCollectionView.reloadItems(at: [indexPath] )}
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
    func showShiftSettingView(){
        shiftSetterView.alpha = 1;
        areUDoneLabel.text = "Are You Done?"
        if !isBottomSheetShown{
        //            bottomView.isHidden = !bottomView.isHidden
                    UIView.animate(withDuration: 0.15, animations: {
                        self.heightConstraint.constant = 200
                        self.trailingConstraint.constant = 10
                        self.view.layoutIfNeeded()
                    }) { (status) in
                        self.isBottomSheetShown = true
                        UIView.animate(withDuration: 0.2) {
                             self.heightConstraint.constant = 150
                            self.view.layoutIfNeeded()
                        }}}}
    func shapingRadius(the views:UIView...){
        for view in views {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        }
    }
    
    func alpahReversing(the views:UIView...){
        for view in views {
            if view.alpha == 1{
                   view.alpha = 0
           }else{view.alpha = 1}
        }
    }
func alpahToZero(the views:UIView...){
        for view in views {
                   view.alpha = 0
        }
    }
func alpahToOne(the views:UIView...){
        for view in views {
                   view.alpha = 1
        }
    }
    override func viewDidAppear(_ animated: Bool) {
           self.trailingConstraint.constant = self.view.frame.width
       }
    
    func hideShiftSettingView(){
        if isBottomSheetShown{
                   UIView.animate(withDuration: 0.1, animations: {
                       self.heightConstraint.constant = 200
                       self.view.layoutIfNeeded()
                   }) { (status) in
                       self.isBottomSheetShown = false;
                       UIView.animate(withDuration: 0.1) {
                           self.heightConstraint.constant = 0
                           self.trailingConstraint.constant = self.view.frame.width

                           self.view.layoutIfNeeded()

                    }}}}}

    //MARK:- DaysCollectionView
extension AddServiceViewController:  UICollectionViewDelegate, UICollectionViewDataSource {
//    @IBOutlet weak var collectionView: UICollectionView!

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Wal: numberOfItemsInSection \(service.availableDaysCount())");
        return service.availableDaysCount()+1;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("myLovelyDay \(myLovelyDay)")

//        var x : String

        func cellSigner(day:String){

            if(day == "Monday") {
                cell.dayLable.text! = "Monday"
                cell.startLabel.text! = service.startEnd["Monday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Monday"]?[1] ?? ""

            }
            else if(day == "Tuesday") {
                cell.dayLable.text! = "Tuesday"
                cell.startLabel.text! = service.startEnd["Tuesday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Tuesday"]?[1] ?? ""

            }
            else if(day == "Wednesday") {
                cell.dayLable.text! = "Wednesday"
                cell.startLabel.text! = service.startEnd["Wednesday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Wednesday"]?[1] ?? ""

            }
            else if(day == "Thursday") {
                cell.dayLable.text! = "Thursday"
                cell.startLabel.text! = service.startEnd["Thursday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Thursday"]?[1] ?? ""

            }
            else if(day == "Friday") {
                cell.dayLable.text! = "Friday"
                cell.startLabel.text! = service.startEnd["Friday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Friday"]?[1] ?? ""

            }
            else if(day == "Saturday") {
                cell.dayLable.text! = "Saturday"
                cell.startLabel.text! = service.startEnd["Saturday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Saturday"]?[1] ?? ""

            }
            else if(day == "Sunday") {
                cell.dayLable.text! = "Sunday"
                cell.startLabel.text! = service.startEnd["Sunday"]?[0] ?? ""
                cell.endLabel.text! = service.startEnd["Sunday"]?[1] ?? ""
            }
            }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! daysCollectionViewCell

        if (indexPath.item == 0){
        daysCollectionView.alpha = 0;
        cell.dayLable.text! = "Day"
        cell.startLabel.text! = "Start"
        cell.endLabel.text! = "End"
        }

        else if (indexPath.item > 0){
            cellSigner(day: finished[indexPath.item-1]);
            cell.dayLable.text! = finished[indexPath.item-1]


             if (service.days["\(finished[indexPath.item-1])1"] == true && service.days["\(finished[indexPath.item-1])2"] == true){
                print("WOW2")
                cell.startLabel.text! = service.startEnd["\(finished[indexPath.item-1])2"]?[0] ?? "MNIL"
                cell.endLabel.text! = service.startEnd["\(finished[indexPath.item-1])2"]?[1] ?? "MNIL"
            }
            else if (service.days["\(finished[indexPath.item-1])1"] == true && service.days["\(finished[indexPath.item-1])2"] == false){
                print("WOW")
            cell.startLabel.text! = service.startEnd["\(finished[indexPath.item-1])1"]?[0] ?? "NNIL"
            cell.endLabel.text! = service.startEnd["\(finished[indexPath.item-1])1"]?[1] ?? "NNIL"
            }
            daysCollectionView.alpha = 1;

        }
        return cell;
           }
}














