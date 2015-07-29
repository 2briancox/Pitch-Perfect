//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Brian on 7/24/15.
//  Copyright (c) 2015 Melodity.com, LLC. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePath: NSURL!
    var title: String!
    
    init (pathArray: NSURL, titlePassed: String) {
        filePath = pathArray
        title = titlePassed
        super.init()
    }
}
