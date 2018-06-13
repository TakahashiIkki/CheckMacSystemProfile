//
//  SystemProfiler.swift
//  CheckMacSystemProfile
//
//  Created by 一騎高橋 on 2018/06/13.
//  Copyright © 2018年 髙橋一騎. All rights reserved.
//

import Foundation

class SystemProfiler {
    enum ListDataTypes: String {
        case camera = "SPCameraDataType"
    }

    
    private let launchPath = "/usr/sbin/system_profiler"
    let arguments: [String]
    
    init(searchFor deviceArg: SystemProfiler.ListDataTypes) {
        self.arguments = ["-xml", deviceArg.rawValue]
    }
    
    func getData() -> Data {
        let task = Process()
        let outputPipe = Pipe()
        task.launchPath = launchPath
        task.arguments = arguments
        task.standardOutput = outputPipe
        task.launch()
        
        return outputPipe.fileHandleForReading.readDataToEndOfFile()
    }
}
