import Foundation

struct Day05 {
    
    func part1() -> Int {
        let input = readFile(fileName: "day_05")
            .map { String($0) }

        print(input)

        var maps 

        for (i, value) in input.enumerated()  {
            print(i, value)
            if(i == 0) {
                // seeds
            } else { 
                if(Array(value)[0].isNumber) {
                    value.split(separator: "\n")

                }
            }
        }


       return 0
    }

 
}