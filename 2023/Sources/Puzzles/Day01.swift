import Foundation

// Trebuchet?!
struct Day01 {
    
    func part1() -> Int {
        return readFile(fileName: "day_01")
            .map { getWordValue(input: String($0)) }
            .reduce(0, +)
    }
    
    func part2() -> Int {
        return readFile(fileName: "day_01")
            .map { converWordToNumbers(word: String($0))}
            .map { getWordValue(input: $0)}
            .reduce(0, +)
    }
    
    private func converWordToNumbers(word: String) -> String  {
        var wordInNumbers = word
        
        for number in numberWords {
            if(wordInNumbers.contains(number.key)) {
                wordInNumbers = wordInNumbers.replacingOccurrences(
                    of: number.key,
                    with: number.key+number.value+number.key
                )
            }
        }
        
        return wordInNumbers
    }
    
    private let numberWords:[String: String] = [
        "zero": "0",
        "one" : "1",
        "two" : "2",
        "three" : "3",
        "four": "4",
        "five" : "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    ]
    
    private func getWordValue(input: String) -> Int {
        var firstDigit = ""
        var lastDigit = ""
        
        // Take 1 - Easier
        //        input.forEach { c in
        //            if c.isNumber {
        //                if firstDigit.isEmpty {
        //                    firstDigit = String(c)
        //                    lastDigit = String(c)
        //                } else {
        //                    lastDigit = String(c)
        //                }
        //            }
        //        }
        
        // Take 2 - performant
        
        let inputLenght = input.count - 1
        
        for i in 0...inputLenght {
            let index = input.index(input.startIndex, offsetBy: i)
            if input[index].isNumber {
                firstDigit = String(input[index])
                break
            }
        }
       
        for i in stride(from: inputLenght, through: 0, by: -1) {
            let index = input.index(input.startIndex, offsetBy: i)
            if input[index].isNumber {
                lastDigit  = String(input[index])
                break
            }
        }
        
        return Int(firstDigit + lastDigit) ?? 0
    }
    
}

