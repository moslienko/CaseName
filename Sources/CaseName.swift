//
//  CaseName.swift
//  CaseName
//
//  Created by Pavel Moslienko on 4 апр. 2021 г..
//  Copyright © 2021 moslienko. All rights reserved.
//

// Include Foundation
@_exported import Foundation

public class CaseName {
    
    public struct Cases {
        public var genitive: String //р.п
        public var dative: String //д.п
        public var accusative: String //в.п
        public var instrumental: String //т.п
        public var prepositional: String //п.п
        
        public init(genitive: String, dative: String, accusative: String, instrumental: String, prepositional: String) {
            self.genitive = genitive
            self.dative = dative
            self.accusative = accusative
            self.instrumental = instrumental
            self.prepositional = prepositional
        }
        
        static func create(name: String) -> Cases {
            let nameSuffix = name.suffix(1) //Окончание имени
            //Последняя буква - согласная
            let isConsonant = CaseName().isConsonantLetter(name: nameSuffix)
            
            if nameSuffix == "ь" {
                return CaseName().optionOne(name: name)
            }
            
            if nameSuffix == "й" || isConsonant {
                return CaseName().optionTwo(name: name, consonant: isConsonant)
            }
            
            if nameSuffix == "а" {
                return CaseName().optionThree(name: name)
            }
            if nameSuffix == "я" {
                return CaseName().optionFour(name: name)
            }
            
            return CaseName.Cases(genitive:name, dative:name, accusative:name, instrumental:name, prepositional:name)
        }
        
        static func create(middleName: String) -> CaseName.Cases {
            let name = middleName
            //let middleNameSuffix = name.suffix(1) //Окончание отчества
            let newMiddleName = String(name.dropLast(1))
            
            if name.suffix(2) == "ич" {
                return CaseName.Cases.init(
                    genitive: name + "а",
                    dative: name + "у",
                    accusative: name + "a",
                    instrumental: name + "ем",
                    prepositional: name + "е"
                )
            }
            
            if name.suffix(2) == "на" {
                return CaseName.Cases(
                    genitive: newMiddleName + "ы",
                    dative: newMiddleName + "е",
                    accusative: newMiddleName + "у",
                    instrumental: newMiddleName + "ой",
                    prepositional: newMiddleName + "е"
                )
                
            }
            return CaseName.Cases(genitive: name, dative: name, accusative: name, instrumental: name, prepositional: name)
        }
    }
    
}

extension CaseName {
    
    /**
     Определение, является ли буква согласной
     - parameter name: Буква
     */
    private func isConsonantLetter(name value:String.SubSequence) -> Bool {
        let consonantLetters = ["б","в","г","д","ж","з","к","л","м","н","п","р","с","т","ф","х","ц","ч","ш","щ"]
        for letter in consonantLetters {
            if letter == value.lowercased() {
                return true
            }
        }
        return false
    }
    
    /**
     Получить союз для предложного падежа
     - parameter firstLeter: Первая буква именмself.
     - description: В предложном падеже перед словами, начинающимися гласными, употребляется предлог "об"
     */
    private func getAboutTitle(firstLeter letter:String.SubSequence) -> String {
        return isConsonantLetter(name: letter) ? "о " : "об "
    }
    
    /**
     Является ли имя мужским, применяется только для склонения по первому варианту
     - parameter name: Имя
     */
    private func isManName(name value:String) -> Bool {
        let manNames = ["Игорь", "Израиль", "Камиль", "Лазарь", "Марсель", "Наиль", "Олесь", "Равиль", "Рамиль", "Фидель", "Цезарь", "Эмиль", "Виль", "Рауль", "Шамиль", "Петрусь"]
        
        for name in manNames {
            if name.lowercased() == value.lowercased() {
                return true
            }
        }
        return false
    }
    
    /**
     Склонение по первому варианту - имена в 3-м склонении (оканчивающиеся на -ь)
     - parameter caseVal: Падеж
     */
    private func optionOne(name:String) -> Cases {
        //Разные правила для мужских и женских имен, оканчивающихся на мягкие согласные
        if isManName(name: name) {
            
            return Cases.init(
                genitive: String(name.dropLast()) + "я",
                dative: String(name.dropLast()) + "ю",
                accusative: String(name.dropLast()) + "я",
                instrumental: String(name.dropLast()) + "ем",
                prepositional: getAboutTitle(firstLeter: name.prefix(1)) +  String(name.dropLast()) + "е"
            )
            
        }
        else {
            
            return Cases.init(
                genitive: String(name.dropLast()) + "и",
                dative: String(name.dropLast()) + "и",
                accusative: name,
                instrumental: String(name.dropLast()) + "ью",
                prepositional: getAboutTitle(firstLeter: name.prefix(1)) +  String(name.dropLast()) + "и"
            )
            
        }
    }
    
    /**
     Исправляет имя для второго варианта, если в нем должны появлятся беглые гласные
     - parameter name: Имя
     */
    private func exceptionForOptionTwo(name:String) -> String {
        if name == "Лев" {
            return "Льв"
        }
        if name == "Павел" {
            return "Павл"
        }
        return name
    }
    
    /**
     Присутствуют ли шипящие в имени
     - parameter letter: Имя
     */
    private func isSizzlingLetter(letter value:String.SubSequence) -> Bool {
        let sizzlingLetters = ["ш","ж","ч","щ","ц"]
        for letter in sizzlingLetters {
            return letter == value.lowercased()
        }
        return false
    }
    
    /**
     Склонение по второму варианту - мужские имена, оканчивающиеся на согласный и на –й:
     - parameters:
     - name: Имя
     - consonant: Оканчивается на согласную
     */
    private func optionTwo(name:String,consonant:Bool) -> Cases {
        if consonant {
            let correctName = exceptionForOptionTwo(name: name) //Для имен - исключений из правил
            //Исправляет окончание в творительном падеже, если в имени есть шипящие или "ц"
            let endingWordForT = isSizzlingLetter(letter: name.suffix(1)) == true ? "ем" : "ом"
            
            return Cases.init(
                genitive: correctName + "а",
                dative: correctName + "у",
                accusative: correctName + "а",
                instrumental: correctName + endingWordForT,
                prepositional: getAboutTitle(firstLeter: name.prefix(1)) + correctName + "е"
            )
            
        }
        else {
            
            return Cases.init(
                genitive: String(name.dropLast()) + "я",
                dative: String(name.dropLast()) + "ю",
                accusative: String(name.dropLast()) + "я",
                instrumental: String(name.dropLast()) + "ем",
                prepositional: getAboutTitle(firstLeter: name.prefix(1)) + String(name.dropLast()) + "е"
            )
            
        }
    }
    
    /**
     Склонение по третьему варианту - мужские и женские имена, оканчивающиеся на –а:
     - parameter caseVal: Падеж
     */
    private func optionThree(name:String) -> Cases {
        
        return Cases.init(
            genitive: String(name.dropLast()) + "ы",
            dative: String(name.dropLast()) + "е",
            accusative: String(name.dropLast()) + "у",
            instrumental: String(name.dropLast()) + "ой",
            prepositional:getAboutTitle(firstLeter: name.prefix(1)) + String(name.dropLast()) + "е"
        )
        
    }
    
    /**
     Получение имени в падежах для четвертого варианта в зависимости от окончания слова
     - parameter name: Имя
     */
    private func endingName(name:String) -> Cases {
        let endingName = name.suffix(2)
        let endingNameOneLetter = name.suffix(1)
        
        if endingName == "ия" {
            //род.,дат.,пр.падежи - одинаково
            let genitive = String(name.dropLast(2)) + "ии"
            let accusative = genitive
            let prepositional = genitive
            
            return Cases.init(genitive:genitive,dative:"", accusative:accusative,instrumental:"",prepositional:prepositional)
        }
        if endingName == "ья" {
            let genitive = String(name.dropLast(1)) + "и"
            let accusative = String(name.dropLast(1)) + "e"
            let prepositional = String(name.dropLast(1)) + "е"
            
            return Cases.init(genitive:genitive,dative:"", accusative:accusative,instrumental:"",prepositional:prepositional)
        }
        
        if endingNameOneLetter == "я", endingName != "ья" {
            let genitive = String(name.dropLast(1)) + "и"
            let accusative = String(name.dropLast(1)) + "ю"
            let dative = String(name.dropLast(1)) + "е"
            let instrumental = String(name.dropLast(1)) + "ей"
            let prepositional = String(name.dropLast(1)) + "е"
            
            return Cases.init(genitive:genitive,dative:dative, accusative:accusative,instrumental:instrumental,prepositional:prepositional)
        }
        //По умолчанию
        let genitive = String(name.dropLast()) + "е"
        let accusative = String(name.dropLast()) + "е"
        let prepositional = String(name.dropLast()) + "е"
        
        return Cases.init(genitive:genitive,dative:"", accusative:accusative,instrumental:"",prepositional:prepositional)
    }
    
    /**
     Склонение по четвертому варианту - мужские и женские имена, оканчивающиеся иа -я, -ья, -ия, -ея:
     - parameter name: Имя
     */
    private func optionFour(name:String) -> Cases {
        let caseWithEndName = endingName(name: name)
        return Cases.init(
            genitive: caseWithEndName.genitive,
            dative: caseWithEndName.dative != "" ? caseWithEndName.dative : String(name.dropLast()) + "е",
            accusative: String(name.dropLast()) + "ю",
            instrumental: caseWithEndName.instrumental != "" ? caseWithEndName.instrumental : String(name.dropLast()) + "ей",
            prepositional:getAboutTitle(firstLeter: name.prefix(1)) + caseWithEndName.prepositional
        )
        
    }
}
