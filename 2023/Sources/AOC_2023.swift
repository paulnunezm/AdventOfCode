// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@main
struct FigletTool {
  static func main() {
    let startTime = DispatchTime.now()
    let result = Day06().part2()
    let endTime = DispatchTime.now()

    print("=================")
    print()
    print("result: \(result)")

    let elapsedTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
    let elapsedTimeInMilliSeconds = Double(elapsedTime) / 1_000_000.0 

    print("time: \(elapsedTimeInMilliSeconds)ms")
    print()
    print("=================")
  }
}
