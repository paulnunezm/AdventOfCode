import Foundation

// If You Give A Seed A Fertilizer
class Day05 {

    func part1() -> Int {
        let input = readFile(fileName: "day_05")
            .map { String($0) }

        let maps = parseMaps(input)
        let seeds = input[0].split(separator: ":")[1]
                        .split(separator: " ")
                        .map { Int(String($0)) ?? 0}

        let locations = seeds.map { seed in 
           return maps.reduce(seed, { acc, next in
                getDestinationFromSource(source: acc, map: next)
            })
        }
       return locations.min() ?? 0
    }

    struct Map {
        let name: String
        let destinationRanges: [ClosedRange<Int>]
        let sourceRanges:[ClosedRange<Int>]
    }


    func getIntersectsAndNonIntersectsFromRange(_ r1: ClosedRange<Int>, _ r2: ClosedRange<Int>) -> ([Int], [Int]) {
        var intersects: [Int] = []
        var nonIntersects: [Int] = []

        for i in r1 {
            if r2.contains(i) {
                intersects.append(i)
            } else {
                nonIntersects.append(i)
            }
        }

        return (intersects, nonIntersects)
    }

    func getSeedRanges(_ seeds: [Int]) -> [ClosedRange<Int>] {
        var ranges : [ClosedRange<Int>] = []
        for i in stride(from: 0, through: seeds.count - 1, by: 2) {
            ranges.append(seeds[i]...seeds[i] + seeds[i + 1])
        }
        return ranges
    }

    func getDestinationFromSource(source: Int, map: Map) -> Int {
        for (i, sourceRange) in map.sourceRanges.enumerated() {
            if sourceRange.contains(source) {
                let range = source - sourceRange.lowerBound
                return map.destinationRanges[i].lowerBound + range
            }
        }
        return source
    }

    func parseMaps(_ input: [String]) -> [Map] {
        var maps: [Map] = []
        var name = ""
        var destinationRanges: [ClosedRange<Int>] = []
        var sourceRanges:[ClosedRange<Int>] = []

        for (i, row) in input.enumerated()  {
            if(i == 0) {
                // seeds line do nothing
            } else {
                if Array(row)[0].isNumber {
                    
                    let values = row.split(separator: "\n")
                        .map { String($0) }
                        .flatMap { $0.split(separator: " ") }
                        .map { Int($0) ?? 0}

                    let destinationRange = values[0]...values[0]+values[2]
                    let sourceRange = values[1]...values[1]+values[2]
                    destinationRanges.append(destinationRange)
                    sourceRanges.append(sourceRange)
                } else {
                    if !name.isEmpty {
                        let map = Map(name: name, destinationRanges: destinationRanges, sourceRanges: sourceRanges)
                        maps.append(map)
                        name = ""
                        destinationRanges = []
                        sourceRanges = []
                    }

                    name = row
                }
            }
        }
        if !name.isEmpty {
            let map = Map(name: name, destinationRanges: destinationRanges, sourceRanges: sourceRanges)
            maps.append(map)
        }
        return maps
    }
}
