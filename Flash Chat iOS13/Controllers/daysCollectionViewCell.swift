//
//  daysCollectionViewCell.swift
//  EService
//
//  Created by admin on 2021-01-24.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class daysCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dayLable: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    func shapingRadius(the view:UIView){
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        shapingRadius(the: startLabel);
//        shapingRadius(the: endLabel);
//        shapingRadius(the: dayLable);
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
}
