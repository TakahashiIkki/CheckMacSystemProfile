//
//  main.swift
//  CheckMacSystemProfile
//
//  Created by 髙橋一騎 on 2018/06/13.
//  Copyright © 2018年 髙橋一騎. All rights reserved.
//

import Foundation

let task = Process()
let outputPipe = Pipe()

task.launchPath = "/usr/sbin/system_profiler"
task.arguments = ["-xml","SPCameraDataType"]
task.standardOutput = outputPipe
task.launch()
let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
var format = PropertyListSerialization.PropertyListFormat.xml

do {
    guard let plistData = try PropertyListSerialization.propertyList(from: outputData, options: [], format: &format) as? [[String: Any]] else {
        print("Cannot Read PlistData.")
        exit(1)
    }
    
    print(plistData[0]["_items"])
} catch {
    print("Error reading plist: \(error), format: \(format)")
    exit(1)
}

exit(0)
