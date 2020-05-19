//
//  StringExt.swift
//  OTUS-Practice
//
//  Created by Mak on 12.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Foundation

extension String {
    
    func getDate(withFormat format: String) -> Date? {
        if self.count < 3 { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    func valid(regExStr: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: regExStr, options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
}
