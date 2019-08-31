//
//  Logger.swift
//  EasyLog
//
//  Created by Tal Sahar on 8/30/19.
//  Copyright © 2019 Tal Sahar. All rights reserved.
//

import Foundation

public class EasyLog {

    public enum LogEvent: String {
        case error = "[❗️]"
        case info = "[ℹ️]"
        case debug = "[💬]"
        case warning = "[⚠️]"
    }
    
    // Configrations may be changed at runtime by developer
    public var config = EasyLogConfig.default

    /// Returns log file urls by current config
    public var logURLs: [URL]? {
        guard let config = config.logFile else {
            return nil
        }
        return LogFileHandle.logURLs(using: config)
    }
    
    public func logsFromDate(_ date: Date) -> [String]? {
        guard let config = config.logFile else {
            return nil
        }
        return LogFileHandle.logsFromDate(date, using: config)
    }
    
    // MARK: - Logging API

    public func error(_ message: String,
                      fileName: String = #file,
                      line: Int = #line,
                      funcName: String = #function) {
        logMessage(message, event: .error, fileName: fileName, line: line, funcName: funcName)
    }
    
    public func info(_ message: String,
                     fileName: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
        logMessage(message, event: .info, fileName: fileName, line: line, funcName: funcName)
    }
    
    public func debug(_ message: String,
                      fileName: String = #file,
                      line: Int = #line,
                      funcName: String = #function) {
        logMessage(message, event: .debug, fileName: fileName, line: line, funcName: funcName)
    }
    
    public func warning(_ message: String,
                        fileName: String = #file,
                        line: Int = #line,
                        funcName: String = #function) {
        logMessage(message, event: .warning, fileName: fileName, line: line, funcName: funcName)
    }
    
    private func logMessage(_ message: String,
                            event: LogEvent,
                            fileName: String = #file,
                            line: Int = #line,
                            funcName: String = #function) {
        
        #if DEBUG
        let log = "\(format(date: Date())) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(funcName) -> \(message)"
        print(log)
        
        if let logFileConfig = config.logFile {
            LogFileHandle.write(log, using: logFileConfig)
        }
        #endif
    }
    
    private func sourceFileName(filePath: String) -> String {
        return filePath.components(separatedBy: "/").last ?? ""
    }
    
    private func format(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = config.logMessage.dateFormat
        return formatter.string(from: date)
    }
}

