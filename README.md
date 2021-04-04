<p align="center">
   <img width="200" src="https://raw.githubusercontent.com/SvenTiigi/SwiftKit/gh-pages/readMeAssets/SwiftKitLogo.png" alt="CaseName Logo">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat" alt="Swift 5.2">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

# CaseName

<p align="center">
CaseName - библиотека на Swift, предназначенная для склонения имен и отчеств на русском языке.
</p>

## Преимущества

- [x] Небольшой размер библиотеки
- [x] Простота установки и использования
- [x] Работа с именами-исключениями, не попадающими под правила
- [x] Добавление склоняемого слова к числу 

## Пример

Пример приложения - лучший способ увидеть `CaseName` в действии. Просто откройте файл `CaseName.xcodeproj` и запустите ` Example`.

## Установка
### Swift Package Manager

Для интеграции с использованием Apple [Swift Package Manager] (https://swift.org/package-manager/) добавьте следующее в качестве зависимости к вашему `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/moslienko/CaseName.git", from: "1.1.0")
]
```

В качестве альтернативы перейдите в свой проект Xcode, выберите «Swift Packages» и щелкните значок «+» для поиска «CaseName».

### Вручную

Если вы предпочитаете не использовать ни один из вышеупомянутых менеджеров зависимостей, вы можете вручную интегрировать CaseName в свой проект. Просто перетащите папку `Sources` в свой проект Xcode.

## Использование
### Пример использование - имя
    let name = "Элла"
    print ("И.П: ",name)
	print ("Р.П: ",name.caseName().genitive)
	print ("Д.П: ",name.caseName().dative)
	print ("В.П: ",name.caseName().accusative)
	print ("Т.П: ",name.caseName().instrumental)
	print ("П.П: ",name.caseName().prepositional)
### Пример использование - отчество
    let middleName = "Викторовна"
    print ("И.П: ",middleName)
	print ("Р.П: ",middleName.caseMiddleName().genitive)
	print ("Д.П: ",middleName.caseMiddleName().dative)
	print ("В.П: ",middleName.caseMiddleName().accusative)
	print ("Т.П: ",middleName.caseMiddleName().instrumental)
	print ("П.П: ",middleName.caseMiddleName().prepositional)
### Пример использование - число
  ```swift
  for i in 1...100 {
            let value = String.caseWordEndingByCount(i, single: "день", genitiveSingle: "дней", genitiveAny: "дня")
            print("value - \(i) \(value)")
        }
//value - 1 день...value - 2 дня...value - 5 дней...value - 44 дня...value - 45 дней
```


## License

```
CaseName
Copyright (c) 2021 Pavel Moslienko 8676976+moslienko@users.noreply.github.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
