extension String {
    
    static func random(length: Int) -> String {
        
        let alphas = UInt8(ascii: "a")...UInt8(ascii: "z")
        let digits = UInt8(ascii: "0")...UInt8(ascii: "9")
        
        let vocabulary =
            digits.reduce("") { $0 + String(Character(UnicodeScalar($1))) }
                + alphas.reduce("") { $0 + String(Character(UnicodeScalar($1))) }
        
        var result: String = ""
        for _ in 0..<length {
            if let randomChar = vocabulary.randomElement() {
                result.append(randomChar)
            }
        }
        return result
    }
}

print(String.random(length: 19))
