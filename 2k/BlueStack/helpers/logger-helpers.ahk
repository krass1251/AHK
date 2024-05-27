LogStart(logText) {
    FormatTime, currentTime,, dd.MM.yyyy HH:mm:ss
    Message := "----------------------------------------`n" . currentTime . "`n" . logText
    LogToFile(Message)
;    LogToTelegram(Message)
}

StartFindEny(funcName, imageNames) {
    FormatTime, currentTime,, dd.MM.yyyy HH:mm:ss
    Message := currentTime . "`nSTART in func: " . funcName . "`nlooking for images: " . imageNames[1] . " " . imageNames[2] . " " . imageNames[3] . " " . imageNames[4] . " " . imageNames[5] . " " . imageNames[6]
    LogToFile(Message)
;    LogToTelegram(Message)
}

LogError(funcName, imageNames, params := false) {
    additionalText := params.additionalText ? params.additionalText : ""

    FormatTime, currentTime,, dd.MM.yyyy HH:mm:ss
    Message := currentTime . "`nERROR in func: " . funcName . "`ncan't find images: " . imageNames[1] . " " . imageNames[2] . " " . imageNames[3] . " " . imageNames[4] . " " . imageNames[5] . " " . imageNames[6] . "`n" . additionalText
    LogToFile(Message)
;    LogToTelegram(Message)
}

LogMessage(message, params := false) {
    FormatTime, currentTime,, dd.MM.yyyy HH:mm:ss
    Message := currentTime . "`n" . message
    LogToFile(Message)
;    LogToTelegram(Message)
}

LogOk(funcName, imageNames, params := false) {
    additionalText := params.additionalText ? params.additionalText : ""

    FormatTime, currentTime,, dd.MM.yyyy HH:mm:ss
    Message := currentTime . "`nOk in func: " . funcName . "`nfind images: " . imageNames[1] . " " . imageNames[2] . " " . imageNames[3] . " " . imageNames[4] . " " . imageNames[5] . " " . imageNames[6] . "`n" . additionalText
    LogToFile(Message)
;    LogToTelegram(Message)
}

LogToFile(Message) {
    ; todo krass add file type as property: log | error | warning
    logFileName := "log\" StartScriptTime "_log.txt"

    if(IS_DEBUG_MODE) {
        logFileName := "1_log.txt"
        FileAppend, `n%Message%`n, %logDebugFileName%

        statusFileName := "2_status.txt"
        FileDelete, %statusFileName%
        FileAppend, `n%Message%`n, %statusFileName%
    }

    ; Append message to the log file
    FileAppend, `n%Message%`n, %logFileName%
}

LogToTelegram(Message) {
   Run, "%APPDATA%\Telegram Desktop\Telegram.exe"
   Sleep, 1000 ;todo use function waithfor to waith for telegram open
   Send, {Escape}
   Sleep, 150
   Send, {Escape}
   Sleep, 150
   PasteText("2k bot logger")
   Sleep, 150
   Send, {Enter}
   Sleep, 300
   PasteText(Message)
   Send, {Enter}
}