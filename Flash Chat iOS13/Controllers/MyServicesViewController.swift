//
//  MyServicesViewController.swift
//  EService
//
//  Created by admin on 2021-01-14.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}



class MyServicesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
       
    var tableViewData = [cellData]()
    var tableViewData1 = [Service]()
    var daysCounter:Int = 0
    var serviceCollectionRef: CollectionReference!


    func sendDataToFirstViewController(myData: [Service]) {
        self.tableViewData1 = myData
       }
    
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableview.reloadData()
        tableview.delegate = self
        tableview.dataSource = self
        
//        if(Constants.User.changed == false){
//        if (Constants.User.UID.count <= 1){
        Constants.User.UID = (Auth.auth().currentUser?.uid ?? "") as String
//            Constants.User.changed = true
//            }}
        print("Wa7a: \(Constants.User.UID)")
            
        
        
        self.serviceCollectionRef = Firestore.firestore().collection("\(Constants.Firebase.USERS)/\(Constants.User.UID)/Service/")
        func loadData(_ a:[Service]) {
            tableViewData1 = a
            print("10LELE:\(self.tableViewData1)")
                var scData = [String]()
                   for service in tableViewData1{
                       var snapXounter = 0
                       for i in 1...(service.availableDaysCount()){
                           snapXounter += 1;
                           scData.append("Cell\(snapXounter)\(i)")
                       }
                       let myCellData = cellData(opened: false, title: "Title\(snapXounter)", sectionData: scData)
                       tableViewData.append(myCellData)
            }
            tableview.reloadData()
        }
serviceCollectionRef.getDocuments { (snapshot, e) in
    if let error = e{
        debugPrint("Error fetching docs: \(error.localizedDescription)")
        return
    }
        guard let snap = snapshot else {return}
        
        for document in (snap.documents){
                let data = document.data()
                print(document.documentID)
                    let fullAddress = data[Constants.Firebase.fullAddress] as? Dictionary<String, String>
                
                let cat:String = data[Constants.Firebase.category] as! String
                let ty:String = data[Constants.Firebase.type] as! String
                guard let coun:String = fullAddress?[Constants.Firebase.country] else {return}
                guard let cit:String = fullAddress?[Constants.Firebase.city] else {return}
                guard let pro:String = fullAddress?[Constants.Firebase.province] else {return}
                guard let add1:String = fullAddress?[Constants.Firebase.address1] else {return}
                guard let add2:String = fullAddress?[Constants.Firebase.address1] else {return}
                guard let zip:String = fullAddress?[Constants.Firebase.zipCode] else {return}
                let days:[String : Bool] = data["days"] as! [String : Bool]
                let startEnd:[String : [String?]] = data["startEnd"] as! [String : [String?]]
            
                let serviceA = Service(category: cat, type: ty, country: coun, city: cit, province: pro, address1: add1, address2: add2, zipCode: zip, status: true)
                            serviceA.days = days
                            serviceA.startEnd = startEnd
    //            self.daysCounter = serviceA.availableDaysCount();
                print("daysCounter: \(self.daysCounter)")
            self.tableViewData1.append(serviceA);

                }
        DispatchQueue.main.async {loadData(self.tableViewData1)}
            
        }
        print("3LELE:\(self.tableViewData1)")

        
        
        
        


    
    
    
    
    
    
//    var serviceX = Service(category: "cat", type: "ty", country: "coun", city: "cit", province: "pro", address1: "add1", address2: "add2", zipCode: "zip", status: true)
//                        serviceX.days["Friday"] = true;
//                        serviceX.days["Saturday"] = true;
//                        serviceX.settingStartTime(day: "Thursday", time: "08:00 AM")
//                        serviceX.settingEndTime(day: "Thursday", time: "10:00 AM")
//                        serviceX.settingStartTime(day: "Saturday", time: "11:00 AM")
//                        serviceX.settingEndTime(day: "Saturday", time: "8:00 PM")
//                        self.tableViewData1.append(serviceX);
    //                    tableViewData = [
    //                    cellData(opened: false, title: "Title1", sectionData: ["Cell10","Cell10q","Cell10qd","Cell10qw"]),
    //                    cellData(opened: false, title: "Title2", sectionData: ["Cell10","Cell10q","Cell10qd","Cell10qw"]),
    //                    cellData(opened: false, title: "Title3", sectionData: ["Cell10","Cell10q","Cell10qd","Cell10qw"])        ]
    
        print("5LELE:\(self.tableViewData1)")
        //Forming table view sections

    
//        print("LELE:\(tableViewData1)")
//        tableViewData1 =

        
        
        
//            var serviceA = Service(category: "cat", type: "ty", country: "coun", city: "cit", province: "pro", address1: "add1", address2: "add2", zipCode: "zip", status: true)
//        serviceA.days["Friday"] = true;
//        serviceA.days["Saturday"] = true;
//        serviceA.settingStartTime(day: "Thursday", time: "08:00 AM")
//        serviceA.settingEndTime(day: "Thursday", time: "10:00 AM")
//        serviceA.settingStartTime(day: "Saturday", time: "11:00 AM")
//        serviceA.settingEndTime(day: "Saturday", time: "8:00 PM")
//        self.tableViewData1.append(serviceA);
//        tableViewData = [
//        cellData(opened: false, title: "Title1", sectionData: ["Cell10","Cell10q","Cell10qd","Cell10qw"]),
//        cellData(opened: false, title: "Title2", sectionData: ["Cell10","Cell10q","Cell10qd","Cell10qw"]),
//        cellData(opened: false, title: "Title3", sectionData: ["Cell10","Cell10q","Cell10qd","Cell10qw"])        ]
//
//
        
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData1.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableViewData[section].opened == true) {
            return tableViewData1[section].availableDaysCount() + 1;
        }
        else{
            return 1;
        }
    }
//    @objc func refresh() {self.tableview.reloadData()}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! Custom1TableTableViewCell? else{return UITableViewCell()}
            cell.serviceCategory.text = tableViewData1[indexPath.section].category
            cell.serviceType.text = tableViewData1[indexPath.section].type
            cell.serviceAddress.text = "\(tableViewData1[indexPath.section].country), \(tableViewData1[indexPath.section].province), \(tableViewData1[indexPath.section].zipCode), \(tableViewData1[indexPath.section].city)"
            cell.serviceSwitch.isOn = tableViewData1[indexPath.section].status
//            cell.serviceImage.image = UIImage(named: "")
//            cell.textLabel?.text = tableViewData[indexPath.section].titlex
            //                let categoryPickerData : [String] = ["Real Estate","Snow Removal and Landscaping","Vehicles","Moving","Beauty","Care Service"];
            //(named: cell.serviceCategory.text);
            
            cell.serviceImage.image = UIImage(named: cell.serviceCategory.text ?? "MyServices");

            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") else{return UITableViewCell()}
            let a = tableViewData1[indexPath.section].availableDaysArray();
            print("a.count \(a.count)")
            cell.textLabel?.text = a[dataIndex];
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
                print("MyServices ..")
            }
            else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .automatic)
            }
        }
    }

    
    @IBAction func AddAServiceButtonPressed(_ sender: UIButton) {
       
        }
        
//        navigationController?.pushViewController(vc, animated: true)

    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "addAService" {
//        let vc = segue.destination as! AddServiceViewController
//        vc.x = tableViewData1;
//        vc.delegate = self
//    }
    
}

