Global emulators := LoadJsonFromFile("variables\emulators.json")

Global StartScriptTime
FormatTime, StartScriptTime,, yyyy.MM.dd_HH.mm.ss

Global IS_SCREEN_DEBUG_MODE := false
;Global IS_SCREEN_DEBUG_MODE := true
Global IS_DEBUG_MODE := false
;Global IS_DEBUG_MODE := true


Global STATE := { isClickAsist: false, isProxy: false }