extension Array{
    
    mutating func myShuffle(){
        var length = count
        for _ in self {
            let randomIndex = Int(arc4random_uniform(UInt32(length)))
            if length - 1 != randomIndex {
                swapAt(length - 1, randomIndex)
            }
            length -= 1
        }
    }
    
    func myShuffled() -> Array {
        var arrayCopy = self
        var length = arrayCopy.count
        for _ in arrayCopy {
            let randomIndex = Int(arc4random_uniform(UInt32(length)))
            if length - 1 != randomIndex {
                arrayCopy.swapAt(length - 1, randomIndex)
            }
            length -= 1
        }
        return arrayCopy
    }
}

func calcLetters(str: String) -> [String: Int] {
    var result: [String: Int] = [:]
    for ch in str {
        result[String(ch), default: 0] += 1
    }
    return result
}
