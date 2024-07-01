
var a: () -> Void = { () -> Void in return print("Hello, world") }

a()

func simpleExample(closure: () -> Void) {
    print("1. Wake up")
    closure()
    print("4. Eat breakfast")
}

simpleExample {
    print("---2. Go to bathroom")
    print("---3. Brush teeth")
}

func passParameters(closure: (Int, Int) -> Void) {
    print("First line")
    closure(4,8)
    print("Second line")
}

passParameters() { x, y in
    print("-- Closure code beginning")
    print("\(x * y)")
    print("-- Ending")
}

func returnValue(closure: (Int, Int) -> Int) {
    print("First line")
    print("\(closure(5,2))")
    print("Second line")
}

returnValue { x, y in
    x + y
}
