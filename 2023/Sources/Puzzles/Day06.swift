
// --- Day 6: Wait For It ---
struct Day06 {

    struct Race {
        let time: Int
        let recordDistance: Int
    }

    func part1() -> Int {
        let input = readFile(fileName: "day_06")
                    .map { s in
                        let row = String(s)
                        let colonIndex = row.firstIndex(of: ":")  
                        let colonIndexInt = row.distance(from: row.startIndex , to: colonIndex ?? row.startIndex)
                        return row.dropFirst(colonIndexInt + 1)
                            .split(separator: " ")
                            .map { Int($0) ?? 0}
                    }

        return getRacesFromInput(input: input)
                .map { waysToBeatRecord(race: $0) }
                .reduce(1, *)
    }

    func part2() -> Int {
        let input = readFile(fileName: "day_06")
            .map { s in
                let row = String(s)
                let colonIndex = row.firstIndex(of: ":")  
                let colonIndexInt = row.distance(from: row.startIndex , to: colonIndex ?? row.startIndex)
                return String(row.dropFirst(colonIndexInt + 1))
            }.map { 
                return Int(String($0).replacingOccurrences(of: " ", with: "")) ?? 0
            }
        guard let time = input.first else {
            print("error reading first element")
            return  0
        }
        guard let distance = input.last else {
            print("error reading last element")
            return 0
        }
        return waysToBeatRecord(race: Race(time: time, recordDistance: distance)) 
    }

    func getRacesFromInput(input: [[Int]]) -> [Race] {

        guard let time = input.first else {
            print("error reading first element")
            return []
        }
        guard let distance = input.last else {
            print("error reading last element")
            return []
        }

        var races: [Race] = []
        for (i, t) in time.enumerated() {
            races.append(Race(time: t, recordDistance: distance[i]))
        }
        print("races \(races)")
        return races
    }

    func waysToBeatRecord(race: Race) -> Int {
        var beatsByHolding: [Int] = []
        for speed in 1...(race.time - 1) {
            let totalDistance = speed * (race.time - speed)
            if(totalDistance > race.recordDistance) {
                beatsByHolding.append(speed)
            }
        }
        return beatsByHolding.count
    }

}
