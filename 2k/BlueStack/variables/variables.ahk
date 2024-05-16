;emulatorNames := ["0 krass1251.tg", "1 master5838.tg", "2 gabriela925.tg" ,"3 howard725.tg" ,"4 griffin261.tg" ,"5 cameron725.tg" ,"6 hampton782.tg" ,"7 lucas4587.tg" ,"8 hutchinson65487.tg" ,"9 wilcox98745.tg" ,"10 manning2589.tg" ,"11 norton3275.tg" ,"12 clark1785.tg" ,"13 rose567822.tg" ,"14 rodgers924.tg" ,"15 quinn2794.tg" ,"16 littele9276.tg" ]
emulatorNames := ["1 master5838.tg", "2 gabriela925.tg" ,"3 howard725.tg" ,"4 griffin261.tg" ,"5 cameron725.tg" ,"6 hampton782.tg" ,"7 lucas4587.tg" ,"8 hutchinson65487.tg" ,"9 wilcox98745.tg" ,"10 manning2589.tg"]

jsonFilePath := "variables\emulators.json"
Global emulators := LoadJsonFromFile(jsonFilePath)

Global StartScriptTime
FormatTime, StartScriptTime,, yyyy.MM.dd_HH.mm.ss

Global IS_DEBUG_MODE := false
Global IS_DEBUG_MODE := true


Global STATE := { isClickAsist: false, isProxy: false }