import Foundation

// Scratchcards 
    var cachedCopiedCards : [Int : [Scratchcard]] = [:]

    struct Scratchcard {
        var gameNumber: Int
        var ownedNumbers: [Int]
        var winningNumbers: [Int]

        func getMatchedNumbers() -> [Int] {
            return winningNumbers.filter {
                ownedNumbers.contains($0)
            }
        }

        func getWorth() -> Int {
            let matchedNumbers = getMatchedNumbers()
            let count = matchedNumbers.count
            if count == 0 {
                return 0 
            }  else if matchedNumbers.count == 1 {
                return 1
            } else {
                let worth = NSDecimalNumber(decimal: pow(2, count - 1))
                return Int(worth)
            }
        }
    }

struct Day04 {

    
    func part1() -> Int {
         let input = readFile(fileName: "day_04")
            .map { String($0) }

        return getScratchCards(input)
            .map { $0.getWorth() }
            .reduce(0, +)
    }

    func part2() -> Int {
         let input = readFile(fileName: "day_04")
            .map { String($0) }

        let originalCards =  getScratchCards(input)
        var copiedCards: [Scratchcard] =  []
        copiedCards += originalCards

        var idx = 0
        while idx < copiedCards.count { 
            let card = copiedCards[idx]
            copiedCards += getCopiedScratchcards(for: card, in: originalCards)
            idx += 1
        }

        return copiedCards.count // 7013204
    }

    func getCopiedScratchcards(for scratchcard: Scratchcard, in originalCards: [Scratchcard]) -> [Scratchcard] {
        let matchedNumbers = scratchcard.getMatchedNumbers().count

        if matchedNumbers == 0 {
            return []
        }

        let gameCachedCopiedCards =  cachedCopiedCards[scratchcard.gameNumber]
        if let gameCachedCopiedCards { 
            return gameCachedCopiedCards
        }

        var copiedCards: [Scratchcard] = []
        for i in 1...matchedNumbers { 
            let cardIdx = scratchcard.gameNumber - 1
            let cardIdxToCopy = cardIdx + i

            if cardIdxToCopy <= originalCards.count - 1 {
                copiedCards.append(originalCards[cardIdxToCopy])
            }
        }

        cachedCopiedCards[scratchcard.gameNumber] = copiedCards
        
        return copiedCards
    }

    func getScratchCards(_ input: [String]) -> [Scratchcard] {
        var scratchards : [Scratchcard] = []
        for (index, line) in input.enumerated() {
            let scratchNumberGameNumbers = line.split(separator: ":")
            let gameNumbers =  scratchNumberGameNumbers[1].split(separator: "|")

            let scratchard = Scratchcard(
                gameNumber: index + 1,
                ownedNumbers:  convertNumberStringToIntArray(gameNumbers[1]),
                winningNumbers: convertNumberStringToIntArray(gameNumbers[0])
            )

            scratchards.append(scratchard)
        }
        return scratchards
    }

    func convertNumberStringToIntArray(_ input: String.SubSequence) -> [Int] {
            return input.split(separator: " ") .map { Int($0) ?? 0}
    }
}
    