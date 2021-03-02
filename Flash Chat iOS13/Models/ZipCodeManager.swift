//
//  zipCodeManager.swift
//  EService
//
//  Created by admin on 2021-02-09.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
protocol ZipCodeDelegate {
    func didUpdateAddressByZipCode(_ ZipCode: ZipCodeManager, address:AddressModel)
    func didFailWithError(_ error:Error)
}
struct ZipCodeManager{
    
    let zipCodeURL = "https://api.zip-codes.com/ZipCodesAPI.svc/1.0/GetZipCodeDetails/"
    var delegate:ZipCodeDelegate?
    
//    let key = "?key=DEMOAPIKEY"
    let key = "?key=52I41WK78ATO9YTPDEFJ"
    func fetchZipCode(code:String){
        
        let urlString = "\(zipCodeURL)\(Utilities.formattingString(string:code))\(key)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { (data, respone, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                else if let safeData = data{
                    if let address = self.parseJSON(safeData){
                        self.delegate?.didUpdateAddressByZipCode(self, address: address);
                    }
                }
            }
            task.resume();
        }
    }
    
    func parseJSON(_ codeData:Data) -> AddressModel?{
        let decoder = JSONDecoder();
        do{
           let decodedData = try decoder.decode(zipCodeData.self, from: codeData);
            let city = decodedData.item.City.capitalized
            var province:String{
                return Utilities.provinceNamesConverter(shortName: decodedData.item.Province);
            }
            let zipCode = decodedData.item.PostalCode
            let address = AddressModel(city: city, zipCode: zipCode, province: province)
            return address
            
        } catch{
            self.delegate?.didFailWithError(error)
            return nil
        }
    }
}

//    "https://app.zipcodebase.com/api/v1/search?apikey=19e481b0-67b0-11eb-bfc5-15d27ad50850"
