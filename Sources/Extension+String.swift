//
//  Extension+String.swift
//  CaseName
//
//  Created by Pavel Moslienko on 04.04.2021.
//  Copyright © 2021 moslienko. All rights reserved.
//

@_exported import Foundation

public extension String {
    
    /**
     Склонение имени
     */
    func caseName() -> CaseName.Cases {
        CaseName.Cases.create(name: self)
    }
    
    /**
     Склонение отчества
     */
    func caseMiddleName() -> CaseName.Cases {
        CaseName.Cases.create(middleName: self)
    }
    
    static func caseWordEndingByCount(_ count: Int, single: String, genitiveSingle: String, genitiveAny: String) -> String {
        let singles = 1
        let exceptions = [0, 11, 12, 13, 14, 15, 16, 17, 18, 19]
        let genitives = [9, 8, 7, 6, 5, 0]
        let nominatives = [4, 3, 2]
        
        if exceptions.contains(count) {
            return genitiveSingle
        }
        if count == singles || count % 10 == singles {
            return single
        }
        if genitives.filter({ count % 10 == $0 }).count > 0 {
            return genitiveSingle
        }
        if nominatives.filter({ count % 10 == $0 }).count > 0 {
            return genitiveAny
        }
        
        return ""
    }
}
