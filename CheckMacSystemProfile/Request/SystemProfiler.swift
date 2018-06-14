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
        
        func getNotExistErrorMessage() -> String {
            switch self {
            case .camera: return "カメラが認識されていません。再起動を試みてください。"
            }
        }
        
        func getExistMessage() -> String {
            switch self {
            case .camera: return "カメラが認識されています。"
            }
        }
    }
    
    private let launchPath = "/usr/sbin/system_profiler"
    let searchDeviceListDataType: SystemProfiler.ListDataTypes
    let arguments: [String]
    
    init(searchFor listDeviceType: SystemProfiler.ListDataTypes) {
        self.searchDeviceListDataType = listDeviceType
        self.arguments = ["-xml", listDeviceType.rawValue]
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
    
    func isExistItem() -> Bool {
        var format = PropertyListSerialization.PropertyListFormat.xml
        let outputData = getData()
        
        do {
            guard let plistData = try PropertyListSerialization.propertyList(from: outputData, options: [], format: &format) as? [[String: Any]] else {
                print("Cannot Read PlistData.")
                return false
            }
            
            if let items = plistData[0]["_items"] as? [[String: Any]] {
                return (items[0]["_name"] != nil)
            } else {
                return false
            }
        } catch {
            print("Error reading plist: \(error), format: \(format)")
            return false
        }
    }
}
