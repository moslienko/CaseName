
# CaseName
CaseName - библиотека на Swift, предназначенная для склонения имен и отчеств на русском языке.
### Преимущества
- Небольшой размер библиотеки

- Простота установки и использования

- Работа с именами-исключениями, не попадающими под правила
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
### Установка
Просто добавьте .swift файл в свой проект