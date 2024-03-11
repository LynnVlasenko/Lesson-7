import UIKit

// ________________________Closures________________________

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


// ---------------ЗАМИКАННЯ (completion)--------------------
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
// --------------------- ЗАМИКАННЯ-------------------------
//________________________Closures________________________


// _______________________PROTOCOL________________________
//  протокол - це інтерфейс. Те як має виглядати якийсь об'єкт - без реалізації
//якби у нас був об'єкт юзера нам головне, щоб він міг робити прописане у протоколі

protocol UserMainInfo {
    func fullInfo() -> String
    func printFullName()
    
    var age: Int {get set}
}

// маємо юзера, але нам треба, щоб він теж мав усе що нам головне (що прописали в протоколі) - і підпорядковуємо його Протоколу
struct User: UserMainInfo {
    // Properties
    var firstName = ""
    var lastName = ""
    
    //UserMainInfo
    func fullInfo() -> String {
        return firstName + " " + lastName
    }
    
    func printFullName() {
        //
    }
    
    var age: Int = 24
}


class Admin {
    var nikname = ""
    var email = ""
}

// маємо Адміна, але нам треба, щоб він теж мав усе що нам головне (що прописали в протоколі) і підпорядковуємо його Протоколу через екстеншн

extension Admin: UserMainInfo {
    func fullInfo() -> String {
        return nikname
    }
    
    func printFullName() {
        //
    }
    
    var age: Int {
        get {
            return 23
        }
        set {
            
        }
    }
}
// !!! Є різниця між тим як ми передаємо дані, коли відразу наслідуємо від протоколу і коли робимо екстенншн. В екстеншн ми маємо вказати і гетер і сетер, якщо є обидва6 коли напряму структуру підпорядковуємось, то можемо тільки сетер наприуклад, або нічого...


//-----------------
//Instans - об'єкт коли дужки є після класу чи стркутупи чи енума

//var users: [Admin(), User()] так не можемо зробити бо типи різні
var users: [UserMainInfo] = [Admin(), User()] // так тепер можемо, бо їх об'єднує протокол (бо мають спільний інтерфейс - протокол тобто)

users[1].age // можемо доступитися до певних даних структури

var currentUser: UserMainInfo?
currentUser = Admin()
currentUser = User()

currentUser?.fullInfo()

// може підтримувати 2 протоколи і протоколи наслідуваться один від одного, але тоді той протокол який наслідуєт має виконати функціоннал обох протоколів



// ________________________GET SET_________________________
// Переслухати ще раз в лекції

// І далі передивитися - про дефолтні функціїї в екстеншенах до протоколів

// ________________________Generic__________________________

// Generic - часто питають що такого класного є в Swift і власнне Generic (почитати приклади в документаціїї)

func printIntValue(intValue: Int) {
    print(intValue)
}

printIntValue(intValue: 23)

// а значення приходвть не в int А в Double
// Окей треба нова функція
func printdoubleValue(doubleValue: Double) {
    print(doubleValue)
}
printdoubleValue(doubleValue: 34.0)

// так як Swift строго типізовани, важко працювати коли приходять різні значення - тому є Generic

func printAnyCustomerValue<T>(value: T) {
    print(value)
}

printAnyCustomerValue(value: 34.0)
printAnyCustomerValue(value: "text")
printAnyCustomerValue(value: 123)

// Accооціате велью - працює так і з протоколами - далі будемо розглядати
