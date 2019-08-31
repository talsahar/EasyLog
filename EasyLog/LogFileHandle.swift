//
//  FileManager.swift
//  EasyLog
//
//  Created by Tal Sahar on 8/30/19.
//  Copyright © 2019 Tal Sahar. All rights reserved.
//

import Foundation

/// You use file handle objects to access logs associated with files
class LogFileHandle {
    private init() {}
    
    /// Returns all log files provided by config
    ///
    /// - Parameter config: Provide us the logs folder path
    /// - Returns: URLs of founded log files
    static func logURLs(using config: EasyLogConfig.LogFile)
        -> [URL]? {
        return try? FileManager.default.contentsOfDirectory(
            at: config.folderPath,
            includingPropertiesForKeys: nil,
            options: [])
    }
    
    static func logsFromDate(_ date: Date, using config: EasyLogConfig.LogFile) -> [String]? {
        guard let fileURL =
        LogFileHandle.logURLs(using: config)?
            .first(where: { url -> Bool in
            url.lastPathComponent == fileName(for: date, using: config)
            }) else { return nil }
        
        guard let content = try? String(contentsOf: fileURL) else {
            return nil
        }
        
        let logs = content.split(separator: "\n").map(String.init)
        return logs
    }
    
    /// Write logs
    static func write(_ log: String,
                             using config: EasyLogConfig.LogFile) {
        guard let logData = "\(log)\n".data(using: .utf8) else { return }
        
        let logFileName = fileName(for: Date(), using: config)
        let url = config.folderPath.appendingPathComponent(logFileName)
        FileManager.default.makeSureFileExists(at: url)
        
        do {
            let fileHandle = try FileHandle(forWritingTo: url)
            fileHandle.seekToEndOfFile()
            fileHandle.write(logData)
            fileHandle.closeFile()
        } catch {
            print("Log write error: \(error)")
        }
    }
    
    private static func fileName(for date: Date,
                                 using config: EasyLogConfig.LogFile) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = config.fileNameDateFormat
        let date = formatter.string(from: date)
        
        let fileName = "log_\(date).txt"
        return fileName
    }
}

fileprivate extension FileManager {
    
    /// Make sure a file exists at specified URL.
    /// It also creates the directory and the file if they are not exists.
    func makeSureFileExists(at url: URL) {
        do {
            let fileManager = FileManager.default
            
            try fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            
            if !fileManager.fileExists(atPath: url.path) {
                fileManager.createFile(atPath: url.path,
                                       contents: nil,
                                       attributes: nil)
            }
        } catch {
            print("Error while creating file with url: \(url)")
        }
    }
}
