//
//  CaseName.swift
//  CaseName
//
//  Created by Pavel Moslienko on 18.09.2018
//  Copyright © 2018 Pavel Moslienko. All rights reserved.
//
import Foundation

extension String {
    
    /**
     Определение, является ли буква согласной
     - parameter name: Буква
     */
    func isConsonantLetter(name value:String.SubSequence) -> Bool {
        let consonantLetters = ["б","в","г","д","ж","з","к","л","м","н","п","р","с","т","ф","х","ц","ч","ш","щ"]
        for letter in consonantLetters {
            if letter == value.lowercased() {
                return true
            }
        }
        return false
    }
    
    /**
     Склонение имени
     - parameter caseVal: Имя
     */
    func caseName(caseVal:String) -> String {
        let name = self
        
        if name.suffix(1) == "ь" {
           return optionOne(name: name, caseVal: caseVal)
        }
        
        let isConsonant = isConsonantLetter(name: name.suffix(1))
        
        if name.suffix(1) == "й" || isConsonant  {
            return optionTwo(name: name, caseVal: caseVal, consonant: isConsonant)
        }
        return name
    }
    
    /**
     Получить союз для предложного падежа
     - parameter firstLeter: Первая буква именм
     */
    func getAboutTitle(firstLeter letter:String.SubSequence) -> String {
        // В предложном падеже перед словами, начинающимися гласными, употребляется предлог об
        if isConsonantLetter(name: letter) {
            return "о "
        }
        return "об "
    }
    
    /**
     Склонение по первому варианту - женские имена в 3-м склонении (оканчивающиеся на -ь)
     - parameters:
        - name: Имя
        - caseVal: Падеж
     */
    func optionOne(name:String,caseVal:String) -> String {
        switch caseVal {
            case "i": return name
            case "r": return String(name.dropLast()) + "и"
            case "d": return String(name.dropLast()) + "и"
            case "w": return name
            case "t": return String(name.dropLast()) + "ью"
            case "p": return getAboutTitle(firstLeter: name.prefix(1)) +  String(name.dropLast()) + "и"

            default: return name
        }
    }
    
    /**
     Склонение по второму варианту - мужские имена, оканчивающиеся на согласный и на –й:
     - parameters:
     - name: Имя
     - caseVal: Падеж
     */
    func optionTwo(name:String,caseVal:String,consonant:Bool) -> String {
        if consonant {
            switch caseVal {
            case "i": return name
            case "r": return name + "а"
            case "d": return name + "у"
            case "w": return name + "а"
            case "t": return name + "ом"
            case "p": return getAboutTitle(firstLeter: name.prefix(1)) + name + "е"
                
            default: return name
            }
        }
        else {
            switch caseVal {
            case "i": return name
            case "r": return String(name.dropLast()) + "я"
            case "d": return String(name.dropLast()) + "ю"
            case "w": return String(name.dropLast()) + "я"
            case "t": return String(name.dropLast()) + "ем"
            case "p": return getAboutTitle(firstLeter: name.prefix(1)) + String(name.dropLast()) + "е"
                
            default: return name
            }
        }
    }
    
}

func demo() {
    let names = ["Иван", "Жизель", "Александр", "Любовь", "Павел", "Алексей", "Михаил","Элла"]
    let cases = ["r", "d", "w", "t", "p"]

    for name in names {
        for caseVal in cases {
            print (name.caseName(caseVal: caseVal))
        }
    }
}
demo()


