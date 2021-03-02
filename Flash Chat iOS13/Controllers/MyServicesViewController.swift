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
       

    
//    var service = Service(category: <#T##String#>, type: <#T##String#>, country: <#T##String#>, city: <#T##String#>, province: <#T##String#>, address1: <#T##String#>, address2: <#T##String#>, zipCode: <#T##String#>, status: <#T##Bool#>)
    
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
        
        
        self.serviceCollectionRef = Firestore.firestore().collection("\(Constants.Firebase.USERS)/\(Constants.User.UID)/Service/")

          
serviceCollectionRef.getDocuments { (snapshot, e) in
    if let error = e{
        debugPrint("Error fetching docs: \(error.localizedDescription)")
    }
    else{
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
            
            
            self.tableViewData1.append(Service(category: cat, type: ty, country: coun, city: cit, province: pro, address1: add1, address2: add2, zipCode: zip, status: true))
            
        }
        
    }}
        
        
        
        // Do any additional setup after loading the view.
        tableViewData = [
        cellData(opened: false, title: "Title1", sectionData: ["CellA","CellB","CellC","CellD"]),
        cellData(opened: false, title: "Title2", sectionData: ["Cell11","Cell21","Cell31","Cell41"]),
        cellData(opened: false, title: "Title3", sectionData: ["Cell01","Cell02","Cell03","Cell04"]),
        cellData(opened: false, title: "Title4", sectionData: ["Cell10","Cell20","Cell30","Cell40"])]
//        service.days["Friday1"] = true;
//        service.days["Saturday1"] = true;
//        service.days["Sunday1"] = true;
//        service.days["Thursday1"] = true;
//        service.settingStartTime(day: "Thursday1", time: "08:00 AM")
//        service.settingEndTime(day: "Thursday1", time: "10:00 AM")

//        service.settingStartTime(day: "Friday1", time: "11:00 AM")
//        service.settingStartTime(day: "Saturday1", time: "9:30 AM")
//        service.settingStartTime(day: "Sunday1", time: "5:00 PM")
//        service.settingEndTime(day: "Friday1", time: "8:00 PM")
//        service.settingEndTime(day: "Saturday1", time: "11:30 AM")
//        service.settingEndTime(day: "Sunday1", time: "9:00 PM")

        
//        daysCounter = service.availableDaysCount();
//        tableViewData1.append(service);
//        tableViewData1.append(service);
//        tableViewData1.append(service);
//        print(daysCounter)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)

    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData1.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableViewData[section] .opened == true) {
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

