//
//  ConversionUtility.swift
//  Noders
//
//  Created by Jose Vildosola on 22-05-15.
//  Copyright (c) 2015 DevIn. All rights reserved.
//

import UIKit

class ConversionUtility: NSObject {
    class func parseISO8601Time(duration: String) -> NSString{
        var dur:NSString = duration
        var hours:NSInteger = 0
        var minutes:NSInteger = 0
        var seconds:NSInteger = 0
        dur = dur.substringFromIndex(dur.rangeOfString("T").location)
        while dur.length > 1 {
            dur = dur.substringFromIndex(1)
            let scanner:NSScanner = NSScanner(string: dur as String)
            var durationPart:NSString?
            scanner.scanCharactersFromSet(NSCharacterSet(charactersInString: "0123456789"), intoString: &durationPart)
            let rangeOfDurationPart:NSRange = dur.rangeOfString(durationPart as! String)
            dur = dur.substringFromIndex(rangeOfDurationPart.location + rangeOfDurationPart.length)
            if dur.substringToIndex(1) == "H" {
                hours = durationPart!.integerValue
            }
            if dur.substringToIndex(1) == "M" {
                minutes = durationPart!.integerValue
            }
            if dur.substringToIndex(1) == "S" {
                seconds = durationPart!.integerValue
            }
        }
        return String(format: "%02d:%02d:%02d",hours,minutes,seconds)
    }
}
