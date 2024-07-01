import UIKit

func descriptiveName() {
    print("Run")
}

descriptiveName()

func multiplyBy2(x: Int) -> Int {
    return x * 2
}

print(multiplyBy2(x: 4))
print(multiplyBy2(x: 17))

// closure
let y = { (x: Int) -> Int in return x * 2 }

print(y(4))
print(y(17))

// omit input and output
let z = { x in return x * 2 }

print(z(4))
print(z(17))

// omit imput arguments
let v = { $0 * 2 }

print(v(4))
print(v(17))

func addNumbers(x: Int, y: Int) -> Int {
    return x + y
}

// omit input type
let a = { (x, y) -> Int in return x + y }

print(a(4,5))
print(a(17,19))

// omit return type
let b = { (x: Int, y: Int) in return x + y }

print(b(4,5))
print(b(17,19))

let c = { (x: Int, y: Int) in x + y }

print(c(4,5))
print(c(17,19))

// 모호성이 있는 경우, 매개변수의 데이터 유형을 명시적으로 정의해야 함
let d = { $0 as Int + $1 as Int }

print(d(4,5))
print(d(17,19))

// 데이터로서의 클로저
print(d(1, d(4,5)))

