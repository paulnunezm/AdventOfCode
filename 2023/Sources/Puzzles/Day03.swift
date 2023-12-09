
struct Day03 {
    
    func part1() -> String {
       let inputArray = readFile(fileName: "day_03")
                .map { Array(String($0))}

        return getAdjacentPositionsForArray(inputArray: inputArray)
                .map { getFullNumberFromParcialPosition(position: $0, input: inputArray) }
                .reduce(0, +)
    }

    struct Position {
        var row: Int
        var column: Int
    }

    func getAdjacentPositionsForArray(inputArray: [[String.Element]]) -> [Position] {
        var parcialAdjacentNumbers : [Position] = []
        let columnsLength = inputArray[0].count - 1 
        let rowsLength = inputArray.count - 1

        for row in stride(from: 0, through: rowsLength, by: 1) {
            for column in stride(from: 0, through: columnsLength, by: 1) {
                let currentValue = inputArray[row][column]
                if !currentValue.isNumber && currentValue != "." {
                    parcialAdjacentNumbers += getAdjacentPositionsForElement(for: Position(row: row, column: column), array: inputArray)
                }
            }
        }

        return parcialAdjacentNumbers
    }

    func getAdjacentPositionsForElement(for position: Position, array: [[String.Element]]) -> [Position] {
        let rowsLength = array.count - 1
        let columnsLength = array[0].count - 1 
        var adjacentPositions : [Position] = []
        var checkTopDiagonal = true 
        var checkBottomDiagonal = true 

         // check top
        if position.row >  0 {
            let a = getElementIfNumber( array: array, row: position.row - 1, column: position.column)
            if !a.isEmpty {
                adjacentPositions += a
                checkTopDiagonal = false
            }
        }
       
       // check right
       if position.column < columnsLength {
           adjacentPositions += getElementIfNumber( array: array, row: position.row, column:  position.column + 1)
       }

        // check bottom
        if position.row < rowsLength {
            let a = getElementIfNumber( array: array, row: position.row + 1, column: position.column)
            if !a.isEmpty {
                adjacentPositions += a
                checkBottomDiagonal = false
            }
        }

       // check left
       if position.column > 0 { 
            adjacentPositions += getElementIfNumber(
                array: array, row: position.row, column: position.column - 1 )
       }

       // we only need to check for TL and TR if we don't have a top adjacent position
       // the same for BL and BR
       // this is because we'll only need the position of one number in order to parse it out
       // that will prevent duplicate parsed numbers
        if checkTopDiagonal {
            // check top left
            if position.column > 0 && position.row > 0 {
                adjacentPositions += getElementIfNumber( array: array, row: position.row - 1, column: position.column - 1 )
            } 

            // check top right
            if position.row >  0 && position.column < columnsLength {
                adjacentPositions += getElementIfNumber( array: array, row: position.row - 1, column: position.column + 1)
            }
        }

        if checkBottomDiagonal {
            // check bottom right
            if position.row < rowsLength && position.column < columnsLength {
                adjacentPositions += getElementIfNumber( array: array, row: position.row + 1, column: position.column + 1)
            }

            // check bottom left
            if position.row < rowsLength && position.column > 0 {
                adjacentPositions += getElementIfNumber( array: array, row: position.row + 1, column: position.column - 1)
            }
        }


        return adjacentPositions
    }

    func getElementIfNumber(array: [[String.Element]], row: Int, column: Int) -> [Position] {
        let c = array[row][column]
        if c.isNumber  {
            return [Position(row: row, column: column)]
        } else {
            return []
        }
    }

    func getFullNumberFromParcialPosition(position: Position, input: [[String.Element]]) -> Int{
        let rowToParse = input[position.row]
        
        // get the start number position
        var startPosition = position.column
        while startPosition - 1 >= 0 && rowToParse[startPosition - 1].isNumber {
            startPosition -= 1
        }

        // get end number position
        var endPosition = position.column
        while endPosition + 1 <= rowToParse.count - 1 && rowToParse[endPosition + 1].isNumber {
            endPosition += 1
        }

        var numberString = ""

        for i in stride(from: startPosition, through: endPosition, by: 1) {
            numberString.append(rowToParse[i])
        }
                    
        return Int(String(numberString)) ?? 0
    }
}