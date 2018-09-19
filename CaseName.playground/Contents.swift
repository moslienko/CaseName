//
//  CaseName.swift
//  CaseName
//
//  Created by Pavel Moslienko on 18.09.2018
//  Copyright © 2018 Pavel Moslienko. All rights reserved.
//
import Foundation

extension String {
    
    struct cases {
        var genitive:String //р.п
        var dative:String //в.п
        var accusative:String //д.р
        var instrumental:String //т.п
        var prepositional:String //п.п
    }
    
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
     */
    func caseName() -> cases {
        let name = self
        let nameSuffix = name.suffix(1) //Окончание имени
        //Последняя буква - согласная
        let isConsonant = isConsonantLetter(name: nameSuffix)
        
        if nameSuffix == "ь" {
           return optionOne(name: name)
        }
        
        if nameSuffix == "й" || isConsonant  {
            return optionTwo(name: name, consonant: isConsonant)
        }
        
        if nameSuffix == "а" {
            return optionThree(name: name)
        }
        if nameSuffix == "я" || name.suffix(2) == "ья" || name.suffix(2) == "ия" || name.suffix(2) == "ея" {
            return optionFour(name: name)
        }
        
        return cases.init(genitive:name, dative:name, accusative:name, instrumental:name, prepositional:name)
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
     Является ли имя мужским, применяется только для склонения по первому варианту
     - parameter name: Имя
     */
    func isManName(name value:String) -> Bool {
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
    func optionOne(name:String) -> cases {
        //Разные правила для мужских и женских имен, оканчивающихся на мягкие согласные
        if isManName(name: name) {
            
            return cases.init(
                genitive: String(name.dropLast()) + "я",
                dative: String(name.dropLast()) + "ю",
                accusative: String(name.dropLast()) + "я",
                instrumental: String(name.dropLast()) + "ем",
                prepositional: getAboutTitle(firstLeter: name.prefix(1)) +  String(name.dropLast()) + "е"
            )

        }
        else {
            
            return cases.init(
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
    func exceptionForOptionTwo(name:String) -> String {
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
    func isSizzlingLetter(letter value:String.SubSequence) -> Bool {
        let sizzlingLetters = ["ш","ж","ч","щ","ц"]
        for letter in sizzlingLetters {
            if letter == value.lowercased() {
                return true
            }
        }
        return false
    }
    
    /**
     Склонение по второму варианту - мужские имена, оканчивающиеся на согласный и на –й:
     - parameters:
        - name: Имя
        - consonant: Оканчивается на согласную
     */
    func optionTwo(name:String,consonant:Bool) -> cases {
        if consonant {
            let correctName = exceptionForOptionTwo(name: name) //Для имен - исключений из правил
            //Исправляет окончание в творительном падеже, если в имени есть шипящие или "ц"
            let endingWordForT = isSizzlingLetter(letter: name.suffix(1)) == true ? "ем" : "ом"
            
            return cases.init(
                genitive: correctName + "а",
                dative: correctName + "а",
                accusative: correctName + "у",
                instrumental: correctName + endingWordForT,
                prepositional: getAboutTitle(firstLeter: name.prefix(1)) + correctName + "е"
            )

        }
        else {
            
            return cases.init(
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
    func optionThree(name:String) -> cases {
        
        return cases.init(
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
    func endingName(name:String) -> cases {
        let endingName = name.suffix(2)
        let endingNameOneLetter = name.suffix(1)

        if endingName == "ия" {
            //род.,дат.,пр.падежи - одинаково
            let genitive = String(name.dropLast(2)) + "ии"
            let accusative = genitive
            let prepositional = genitive
            
            return cases.init(genitive:genitive,dative:"", accusative:accusative,instrumental:"",prepositional:prepositional)
        }
        if endingName == "ья" {
            let genitive = String(name.dropLast(1)) + "и"
            let accusative = String(name.dropLast(1)) + "e"
            let prepositional = String(name.dropLast(1)) + "е"
            
            return cases.init(genitive:genitive,dative:"", accusative:accusative,instrumental:"",prepositional:prepositional)
        }
        
        if endingNameOneLetter == "я", endingName != "ья" {
            let genitive = String(name.dropLast(1)) + "и"
            let accusative = String(name.dropLast(1)) + "е"
            let dative = String(name.dropLast(1)) + "ю"
            let instrumental = String(name.dropLast(1)) + "ей"
            let prepositional = String(name.dropLast(1)) + "е"
            
            return cases.init(genitive:genitive,dative:dative, accusative:accusative,instrumental:instrumental,prepositional:prepositional)
        }
        //По умолчанию
            let genitive = String(name.dropLast()) + "е"
            let accusative = String(name.dropLast()) + "е"
            let prepositional = String(name.dropLast()) + "е"
            
            return cases.init(genitive:genitive,dative:"", accusative:accusative,instrumental:"",prepositional:prepositional)
    }
    
    /**
     Склонение по четвертому варианту - мужские и женские имена, оканчивающиеся иа -я, -ья, -ия, -ея:
     - parameter name: Имя
     */
    func optionFour(name:String) -> cases {
        let caseWithEndName = endingName(name: name)

        return cases.init(
            genitive: caseWithEndName.genitive,
            dative: caseWithEndName.dative != "" ? caseWithEndName.dative : String(name.dropLast()) + "ю",
            accusative: String(name.dropLast()) + "е",
            instrumental: caseWithEndName.instrumental != "" ? caseWithEndName.instrumental : String(name.dropLast()) + "ей",
            prepositional:getAboutTitle(firstLeter: name.prefix(1)) + caseWithEndName.prepositional
        )

    }
    
}

let names1 = ["Иван", "Жизель", "Александр", "Любовь", "Павел", "Алексей", "Михаил","Элла", "Алиса", "Илья", "Наталья", "Мария"]
let names2 = ["Иван", "Святослав", "Тимур", "Рем"]
let names3 = ["Петр", "Лев", "Павел", "Фрол"]
let names4 = ["Юмаш", "Жорж", "Ференц", "Казбич"]
let names5 = ["Игорь", "Любовь", "Виль", "Рауль", "Шамиль", "Петрусь"]
let names6 = ["Никита", "Данила", "Кузьма", "Мустафа"]
let names7 = ["Олеся", "Дарья", "Алиса"]

func demo(names:[String]) {

    for name in names {
        print ("И.П: ",name)
        print ("Р.П: ",name.caseName().genitive)
        print ("Д.П: ",name.caseName().accusative)
        print ("В.П: ",name.caseName().dative)
        print ("Т.П: ",name.caseName().instrumental)
        print ("П.П: ",name.caseName().prepositional)
        
        print ("\n")

    }
}

demo(names: names7)
