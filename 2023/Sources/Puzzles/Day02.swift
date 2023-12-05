//
//  File.swift
//  
//
//  Created by Paul Nunez on 12/4/23.
//

import Foundation

// Cube Conundrum
struct Day02 {
    
    func part1() -> Int {
        return readFile(fileName: "day_02")
            .map { String($0) }
            .map { $0.split(separator: ":") } // A row = "Game 4", "14 red; 1 red, 2 blue"
            .filter { isPossibleGame(row: $0)}
            .map {
                let startIndex = $0.index($0.startIndex, offsetBy: 0)
                let gameIdString = $0[startIndex] // Game 4
                    .replacingOccurrences(of: "Game ", with: "")
                return Int(gameIdString) ?? 0
            }
            .reduce(0, +)
    }
    
    func part2() -> Int {
       return readFile(fileName: "day_02")
            .map { String($0) }
            .map { $0.split(separator: ":") } // A row = "Game 4", "14 red; 1 red, 2 blue"
            .map { getPowerOfCubeSets(row: $0)}
            .reduce(0, +)
    }
    
    private func isPossibleGame(row: [String.SubSequence]) -> Bool {
        let redCubes = 12
        let greenCubes = 13
        let blueCubes = 14
        
        let gameSetsString = row.dropFirst() //the first element is "Game 4"
        let startIndex = gameSetsString.index(gameSetsString.startIndex, offsetBy: 0)
        let cubeSets = gameSetsString[startIndex]
            .replacingOccurrences(of: " ", with: "")
            .split(separator: ";")
        
        for cubeSet in cubeSets {
            let cubesInSet = cubeSet.split(separator: ",")
            
            for cube in cubesInSet {
                if cube.contains("red") {
                    let n = cube.replacingOccurrences(of: "red", with: "")
                    let count = Int(n) ?? 0
                    if count > redCubes {
                        return false
                    }
                } else if cube.contains("blue") {
                    let n = cube.replacingOccurrences(of: "blue", with: "")
                    let count = Int(n) ?? 0
                    if count > blueCubes {
                        return false
                    }
                } else  {
                    let n = cube.replacingOccurrences(of: "green", with: "")
                    let count = Int(n) ?? 0
                    if count > greenCubes {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    private func getPowerOfCubeSets(row: [String.SubSequence]) -> Int {
        var redCubes = 0
        var greenCubes = 0
        var blueCubes = 0
        
        let gameSetsString = row.dropFirst() //the first element is "Game 4"
        let startIndex = gameSetsString.index(gameSetsString.startIndex, offsetBy: 0)
        let cubeSets = gameSetsString[startIndex]
            .replacingOccurrences(of: " ", with: "")
            .split(separator: ";")
        
        
        for cubeSet in cubeSets {
            let cubesInSet = cubeSet.split(separator: ",")
            
            for cube in cubesInSet {
                if cube.contains("red") {
                    let n = cube.replacingOccurrences(of: "red", with: "")
                    redCubes = max(Int(n) ?? 0, redCubes)
                } else if cube.contains("blue") {
                    let n = cube.replacingOccurrences(of: "blue", with: "")
                    blueCubes = max(Int(n) ?? 0, blueCubes)
                } else  {
                    let n = cube.replacingOccurrences(of: "green", with: "")
                    greenCubes = max(Int(n) ?? 0, greenCubes)
                }
            }
        }
        
        return redCubes * blueCubes * greenCubes
    }
}
