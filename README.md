## EasyLog
Simple, pretty and powerful logger for iOS

### Setup
Clone and add .swift files to your project.

Initialize as a global variable
```swift
let log = EasyLog()
```
And use
```swift
log.info("info")
log.info("debug")
log.info("warning")
log.error("error")
```

### Output
<img src='https://i.imgur.com/Z3c1qQJ.png'/>

### Log to file
To log to a file you must set the path to you logs folder.
For each day, the logger will create and write logs at the same log_YY-MM-dd.txt file where YY-MM-dd represents it's date.
```swift
let logFolder = URL(fileURLWithPath: "logs/", isDirectory: true)
log.config.logFile = EasyLogConfig.LogFile(folderPath: logFolder)
```

You also can determine file's date format
```swift
let logFolder = URL(fileURLWithPath: "logs/", isDirectory: true)
log.config.logFile = EasyLogConfig.LogFile(folderPath: logFolder, fileNameDateFormat: "YY_MM_dd")
```

### Reading log file
Read logs from specific date
```swift
let todayLogs: [String]? = log.logsFromDate(Date())
```
Note: The log file path must be configured, otherwise the logger won't find the log file.
