//
//  File.swift
//  
//
//  Created by Paul Nunez on 12/4/23.
//

import Foundation


func readFile(fileName: String,_ separator: String = "") -> [Substring] {
    
   let inputUrl = Bundle.module.url(
    forResource: fileName,
    withExtension: "txt",
    subdirectory: "Resources"
    )
    
     guard let inputUrl,
       let data = try? String(contentsOf: inputUrl)
     else {
       fatalError("Couldn't find file \(fileName).txt' in the 'Resources' directory.")
     }

  
    let nData = data.split(separator: "\n")
    
    return nData
}
