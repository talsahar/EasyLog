//
//  EasyLogConfigurations.swift
//  EasyLog
//
//  Created by Tal Sahar on 8/30/19.
//  Copyright © 2019 Tal Sahar. All rights reserved.
//

import Foundation

/// Configurations
public struct EasyLogConfig {
    public static let `default` = EasyLogConfig()
    
    public var logFile: LogFile?
    public var logMessage: LogMessage = LogMessage()
}

// MARK: - Log Message configurations
public extension EasyLogConfig {
    struct LogMessage {
        public var dateFormat: String = "HH:mm:ss" // Log message date format
    }
}

// MARK: - Log File configurations
public extension EasyLogConfig {
    struct LogFile {
        public var folderPath: URL // Log files location
        public var fileNameDateFormat: String
        
        public init(folderPath: URL, fileNameDateFormat: String = "YY-MM-dd") {
            self.folderPath = folderPath
            self.fileNameDateFormat = fileNameDateFormat
        }
    }
}
