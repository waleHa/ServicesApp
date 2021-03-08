//
//  Utilites.swift
//  EService
//
//  Created by admin on 2021-01-28.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class Utilities{
    static func styleTextField(_ textfield: UITextField){
               let bottomLine = CALayer()
               
               bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
               
               bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
               
               //remove border on textField
               textfield.borderStyle = .none
               
               //Add line to the text field
               
               textfield.layer.addSublayer(bottomLine)
        }
    static func styleFilledButton(_ button: UIButton,withCornerSize x:Float, color: UIColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)) {
        
        // Filled rounded corner style
        button.backgroundColor = color
        button.layer.cornerRadius = CGFloat(x)
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton, withCornerSize x:Float) {
        button.layer.borderWidth = 2;
        button.layer.borderColor = UIColor.white.cgColor;
        button.layer.cornerRadius = CGFloat(x);
        button.tintColor = UIColor.white;
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let pattern =  "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@" , pattern);
        return passwordTest.evaluate(with: password);
    }

    static func formattingString(string:String)->String{
        let s = string.trimmingCharacters(in: .whitespacesAndNewlines)
    return s.replacingOccurrences(of: " ", with: "") // result: "no space!"
    }
    
    static func provinceNamesConverter(shortName:String)->String{
        if (shortName == "AB"){return "Alberta"}
        else if(shortName == "ON"){return "Ontario"}
        else if(shortName == "BC"){return "British Columbia"}
        else if(shortName == "NL"){return "Newfoundland"}
        else if(shortName == "MB"){return "Manitoba"}
        else if(shortName == "NB"){return "New Brunswick"}
        else if(shortName == "NT"){return "Northwest Territories"}
        else if(shortName == "NS"){return "Northwest  Scotia"}
        else if(shortName == "NU"){return "Nunavut"}
        else if(shortName == "PE"){return "Prince Edward Island"}
        else if(shortName == "QC"){return "Quebec"}
        else if(shortName == "SK"){return "Saskatchewan"}
        else if(shortName == "YT"){return "Yukon"}
        return shortName

    }

    static func dialNumber(_ number : String) {

        
        
        if let url = URL(string: "TEL   ://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
}

