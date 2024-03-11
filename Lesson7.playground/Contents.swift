import UIKit

// Closures

// глобальна функція - кложура - це глобальна функція

func dfdsf() {
    
}

class AppDelegat {
    
}

//-------

func someFunc() {
    func dfdsf() { //вкладена функція теж є кложура
        
    }
}

// Структура кложури
/*
{ (parameters) -> return type in
    statements
}
*/

let printClosure: () -> () //резервація типу () -> () - щось приймає, щось повертає
// цей запис схожий на цей по факту
let someStr: String = ""

let printClosure1: () -> () = {
    print("printClosure1")
}
printClosure1()

// коли ми маємо параметр на вході, то маємо вказати назву цього вхідного параметру (для прикладу - intValue) та in
let closureWiyhParameters: (Int) -> () = { intValue in
    print("closureWiyhParameters \(intValue)")
}

closureWiyhParameters(21)

// коли кложура ннічого не приймає, але повертає - ми не вказуємо назву параметру що входить, і маємо повернути значення вказаного типу
//щодо прописуванння return або ні - можуть бути правила на проекті, що усі пишкуть, навіть коли один рядок і по факту можнна не писати
var closureWiyhReturnValue: () -> (Int) = {
    return Int.random(in: 0...100)
}

let randomResult = closureWiyhReturnValue()
print("Random is \(randomResult)")

// в кложури можна переписувати значенння як для змінної
closureWiyhReturnValue = {
    return 54
}
closureWiyhReturnValue()
print(randomResult)


// ------------------- ЗАМИКАННЯ-------------------------
// тут вже використання кложур як ЗАМИКАННЯ - зазвичай пишуть як completion
func doAnotherLogic(completion: () -> ()) {
    print("start doAnotherLogic") //для показу що почалось виконуватись
    completion()
    print("finish doAnotherLogic") //для показу що закінчило виконуватись
}


doAnotherLogic(completion: printClosure1) // тобто в параметр передали теж кложуру, яку раніше створили

doAnotherLogic {
    print("Code Block -> doAnotherLogic") //тут прописуємо, що ми хочемо виконати у completion у кложурі doAnotherLogic
}

// коли код виконується довше
print("\n\n")
doAnotherLogic {
    DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
        print("7 sec left") // тут прописуємо, що ми хочемо виконати у completion у кложурі doAnotherLogic (але виконається уже після 2 принтів в кложурі, бо виконається через 5 секунд)
    }
}

// використання для оновлення значення - як захоплення значення з someResult
var someResult = "no data"
print("\n\n")
doAnotherLogic { //[someResult] in - тут не працює, бо треба ще параметри в [], потім будемо розглядати
    someResult = "another data in closure"
    print(someResult)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        print("main.asyncAfter before is: \(someResult)")
        print("5 sec left") // тут прописуємо, що ми хочемо виконати у completion у кложурі doAnotherLogic (але виконається уже після 2 принтів в кложурі, бо виконається через 5 секунд)
        someResult = "(someResult was used)"
        print("main.asyncAfter after callback and change \(someResult)")
    }
}
someResult = "waiting for data"
print("some \(someResult)")


// варіант з поверненням значення
func doRandom(completion: () -> (Int)) {
    print("start doAnotherLogic") //для показу що почалось виконуватись
    print (completion())
    print("finish doAnotherLogic") //для показу що закінчило виконуватись
}

doRandom {
    return Int.random(in: 200...300)
}
// ------------------- ЗАМИКАННЯ-------------------------



// extansion
