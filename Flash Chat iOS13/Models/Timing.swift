//
//  Timing.swift
//  EService
//
//  Created by admin on 2021-01-18.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation

class Timing{
    let day: Day
    var interval1: Interval! = nil
    var interval2: Interval! = nil
    
    enum Day {
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }
    enum Hours : Int{
        case AM1 = 1, AM2 = 2, AM3 = 3, AM4 = 4, AM5 = 5, AM6 = 6, AM7 = 7, AM8 = 8, AM9 = 9, AM10 = 10, AM11 = 11, PM12 = 12, PM1 = 13,PM2 = 14, PM3 = 15, PM4 = 16, PM5 = 17, PM6 = 18, PM7 = 19, PM8 = 20, PM9 = 21, PM10 = 22, PM11 = 23, AM12 = 24
    }
    struct Interval{
        var startTime:Hours
        var endTime:Hours
    }
    
    init (day: Day,interval1:Interval, interval2:Interval) {
        self.day = day
        self.interval1.startTime = interval1.startTime
        self.interval1.endTime = interval1.endTime
        self.interval2.startTime = interval2.startTime
        self.interval2.endTime = interval2.endTime
    }

    func isTimeEqual(interval1:Interval,interval2:Interval)-> Bool{
        if (interval1.endTime.rawValue == interval2.startTime.rawValue){
                return true;
        }
        return false;
          }
    
    func TimeChecker(interval1:Interval,interval2:Interval)-> Bool{
        if (interval1.startTime.rawValue > interval2.startTime.rawValue){
            if (interval1.endTime.rawValue > interval2.startTime.rawValue){
                return true;
            }
        }
        else if (interval1.startTime.rawValue < interval2.startTime.rawValue){
            if (interval1.endTime.rawValue < interval2.startTime.rawValue){
                return true;
            }
        }
        return false;
    }
    
}
