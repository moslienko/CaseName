//
//  ViewController.swift
//  Example
//
//  Created by Pavel Moslienko on 4 апр. 2021 г..
//  Copyright © 2021 moslienko. All rights reserved.
//

import UIKit
import CaseName

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {
    
    // MARK: Properties
    
    /// The Label
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "🚀\nCaseName\nExample"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    // MARK: View-Lifecycle
    
    /// View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.testingDemoData()
    }
    
    /// LoadView
    override func loadView() {
        self.view = self.label
    }
    
    private func testingDemoData() {
        let names = [
            ["Иван", "Жизель", "Александр", "Любовь", "Павел", "Алексей", "Михаил","Элла", "Алиса", "Илья", "Наталья", "Мария"],
            ["Петр", "Лев", "Павел", "Фрол"],
            ["Юмаш", "Жорж", "Ференц", "Казбич"],
            ["Игорь", "Любовь", "Виль", "Рауль", "Шамиль", "Петрусь"],
            ["Никита", "Данила", "Кузьма", "Мустафа"],
            ["Олеся", "Дарья", "Илья"]
        ]
       
        let middleNames = ["Евгеньевич", "Владимировна", "Никитич"]
        
        self.demoName(names: names.randomElement() ?? [])
        self.demoMiddleName(names: middleNames)
        self.demoNumbers()
    }
}

extension ViewController {
    
    private func demoName(names:[String]) {        
        for name in names {
            print ("И.П: ",name)
            print ("Р.П: ",name.caseName().genitive)
            print ("Д.П: ",name.caseName().dative)
            print ("В.П: ",name.caseName().accusative)
            print ("Т.П: ",name.caseName().instrumental)
            print ("П.П: ",name.caseName().prepositional)
            
            print ("\n")
        }
    }
    
    private func demoMiddleName(names:[String]) {
        
        for name in names {
            print ("И.П: ",name)
            print ("Р.П: ",name.caseMiddleName().genitive)
            print ("Д.П: ",name.caseMiddleName().dative)
            print ("В.П: ",name.caseMiddleName().accusative)
            print ("Т.П: ",name.caseMiddleName().instrumental)
            print ("П.П: ",name.caseMiddleName().prepositional)
            
            print ("\n")
        }
    }
    
    private func demoNumbers() {
        for i in 1...100 {
            let value = String.caseWordEndingByCount(i, single: "день", genitiveSingle: "дней", genitiveAny: "дня")
            print("value - \(i) \(value)")
        }
        
    }
    
}
