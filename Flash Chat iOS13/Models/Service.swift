//
//  Service.swift
//  EService
//
//  Created by admin on 2021-01-18.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

class Service{
    var category:String
    var type:String
    var country:String
    var city:String
    var province:String
    var zipCode:String
    var address1:String
    var address2:String
    var status:Bool = true
    
    init(category:String, type:String, country:String, city:String, province:String,address1:String,address2:String, zipCode:String, status:Bool){
        self.category = category;
        self.type = type;
        self.country = country
        self.city = city
        self.province = province
        self.zipCode = zipCode
        self.status = status
        self.address1 = address1
        self.address2 = address2
    }
    
    
    var days: [String : Bool] = ["Monday" : false, "Tuesday" : false, "Wednesday" : false, "Thursday" : false, "Friday" : false, "Saturday" : false, "Sunday" : false]

    
    var startEnd : [String:[String?]] = ["Monday" : [nil, nil], "Tuesday" : [nil, nil],  "Wednesday" : [nil, nil],   "Thursday" : [nil, nil],  "Friday" : [nil, nil],   "Saturday" : [nil, nil],    "Sunday" : [nil, nil]]
//        service.days["Thursday1"] = true;
//    startEnd[Thursday]?[0] = "08:00 AM"
//    startEnd[Thursday]?[1] = "08:00 AM"


    func availableDaysCount() ->Int{
        var counter = 0;
        for (_, b) in days {
                if(b==true){counter+=1}
            }
        return counter;
    }
    func availableDaysArray() ->[String]{
        var daysArray:[String] = []
        if(days["Monday"]==true){
            daysArray.append("Monday - Start: \(startEnd["Monday"]?[0] ?? ""), End: \(startEnd["Monday"]?[1] ?? "")")
        }
        if(days["Tuesday"]==true){
            daysArray.append("Tuesday - Start: \(startEnd["Tuesday"]?[0] ?? ""), End: \(startEnd["Tuesday"]?[1] ?? "")")
        }

        if(days["Wednesday"]==true){
            daysArray.append("Wednesday - Start: \(startEnd["Wednesday"]?[0] ?? ""), End: \(startEnd["Wednesday"]?[1] ?? "")")
        }

        if(days["Thursday"]==true){
            daysArray.append("Thursday - Start: \(startEnd["Thursday"]?[0] ?? ""), End: \(startEnd["Thursday"]?[1] ?? "")")
        }

        if(days["Friday"]==true){
            daysArray.append("Friday - Start: \(startEnd["Friday"]?[0] ?? ""), End: \(startEnd["Friday"]?[1] ?? "")")
        }
        if(days["Saturday"]==true){
            daysArray.append("Saturday - Start: \(startEnd["Saturday"]?[0] ?? ""), End: \(startEnd["Saturday"]?[1] ?? "")")
        }
        if(days["Sunday"]==true){
            daysArray.append("Sunday - Start: \(startEnd["Sunday"]?[0] ?? ""), End: \(startEnd["Sunday"]?[1] ?? "")")
        }

        return daysArray;
    }

    
    func settingStartTime(day: String, time:String){
        startEnd[day]?[0] = time
    }
    func settingEndTime(day: String, time:String){
        startEnd[day]?[1] = time
    }

                    
}


