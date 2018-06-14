//
//  main.swift
//  CheckMacSystemProfile
//
//  Created by 髙橋一騎 on 2018/06/13.
//  Copyright © 2018年 髙橋一騎. All rights reserved.
//

import Foundation

let systemProfiler = SystemProfiler(searchFor: SystemProfiler.ListDataTypes.camera)

if systemProfiler.isExistItem() {
    print(systemProfiler.searchDeviceListDataType.getExistMessage())
    exit(0)
} else {
    print(systemProfiler.searchDeviceListDataType.getNotExistErrorMessage())
    exit(1)
}
