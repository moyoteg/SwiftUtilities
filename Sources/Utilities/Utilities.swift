struct Utilities {
    var text = "Hello, World!"
}

func byteArray<T>(_ value: T) -> [UInt8] {
    var value = value
    var initialArray = withUnsafeBytes(of: &value) { Array($0) }

    initialArray.reverse()
    var count = initialArray.count
    while initialArray.first == 0 && count > 1 {
        initialArray[0...count - 2] = initialArray[1...count - 1]
        count -= 1
    }
    if initialArray[0] >= 128 {
        var newArray = [UInt8](repeating: 0, count: count + 1)
        newArray[0] = UInt8(0)
        newArray[1...count] = initialArray[0...count - 1]
        return newArray
    } else {
        return Array(initialArray[0...count - 1])
    }
}
