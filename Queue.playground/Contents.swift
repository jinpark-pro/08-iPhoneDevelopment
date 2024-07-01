import UIKit

let queue1 = DispatchQueue(label: "queue1")
let queue2 = DispatchQueue(label: "queue2")
let queue3 = DispatchQueue(label: "queue3")

queue1.async { () -> Void in
    print(queue1.label)
}

queue2.async { () -> Void in
    print(queue2.label)
}

queue3.async { () -> Void in
    print(queue3.label)
}

print("Program Stopped")

queue1.sync { () -> Void in
    print("Sync \(queue1.label)")
}

queue2.sync { () -> Void in
    print("Sync \(queue2.label)")
}

queue3.sync { () -> Void in
    print("Sync \(queue3.label)")
}

print("Sync Program Stopped")
