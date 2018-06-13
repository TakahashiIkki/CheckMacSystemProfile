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
task.arguments = ["SPCameraDataType"]
task.standardOutput = outputPipe
task.launch()
let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()

print(String(data: outputData, encoding: .utf8))
