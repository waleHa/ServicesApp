//
//  Constants.swift
//  EService
//
//  Created by admin on 2021-02-02.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

struct Constants {
    struct Segues {
        static let registerToMain = "RegisterToMain"
    }
    struct yohoInfo {
    static let email = "yoho.serv@gmail.com"
    static let phone = "226-503-3915"
    }
    struct Storyboard {
        static let mainViewController = "MainViewController"
    }
    struct Firebase {
        static let CATEGORIES = "categories"
        static let USERS = "users"
        static let COUNTRIES = "Countries"
        static let UID = "UID"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let fullAddress = "fullAddress"
        static let address1 = "address"
        static let address2 = "unit"
        static let city = "city"
        static let province = "province"
        static let zipCode = "postalCode"
        static let country = "country"
        static let phoneNumber = "phoneNumber"
        static let isUserAProvider = "isUserAProvider"
        static let category = "category"
        static let type = "type"
        
    }
    struct Services {
//        ["Real Estate","Snow Removal and Landscaping","Vehicles","Moving","Beauty","Care Service"]
        static let RealEstate = "Real Estate"
        static let SnowRemovalandLandscaping = "Snow Removal and Landscaping"
        static let Vehicles = "Vehicles"
        static let Moving = "Moving"
        static let Beauty = "Beauty"
        static let CareService = "Care Service"
    }
    struct User{
        static var UID = String()
        static var changed = false
    }
    
}
