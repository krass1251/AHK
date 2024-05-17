runEmulator(emulatorName) {
    WinClose, BlueStacks Multi Instance Manager
    Sleep, 300
    Run, "C:\Program Files\BlueStacks_nxt\HD-MultiInstanceManager.exe"

    if(ClickToEny(["BS_stopAll"], { maxWaitTimeSec: 5 })) {
        ClickToEny(["BS_closeAll"])
    }


    ClickToEny(["bs_Search1", "bs_Search2"], { clickPosition: [-2, 0.5]})
    Send, ^a
    Send, {Backspace}
    SendRaw(emulatorName)
    ClickToEny(["BS_startEmulator"])
    ClickToEny(["Android_max-view"])

    Return WaithForEny(["prx_postern", "clickAsist", "telegramLogo2", "telegramLogo"], { maxWaitTimeSec: 120 })
}

closeEmulator() {
    ClickToEny(["Android_close"])
    return ClickToEny(["Android_close-confirm", "Android_close-confirm2"], { sleepAfter: 1500 })
}

androidResetApps() {
    ClickToEny(["Android_resentApp"])
    ClickToEny(["Android_clearAll", "Android_clearAll2", "Android_clearAll3", "Android_clearAll4", "Android_clearAll5"], { maxWaitTimeSec: 30, variation: 20 })
;    if (!ClickToEny(["Android_clearAll", "Android_clearAll2", "Android_clearAll3", "Android_clearAll4"])) {
;        CoordMode, Mouse, Screen
;        MouseMove, 1550, 120
;        Sleep, 200
;        Click, Left, 1
;        Sleep, 200
;    }
}

openTelegram(){
;    androidResetApps()
    ClickToEny(["telegramLogo2", "telegramLogo", "telegramLogo3", "telegramLogo4"])
    if (ClickToEny(["telegram_contact-ok"], { maxWaitTimeSec: 5 })) {
        ClickToEny(["android-allow"], { maxWaitTimeSec: 5 })
        ClickToEny(["android-allow"], { maxWaitTimeSec: 5 })
    }
    ClickToEny(["telegram-update-latter", "telegram-update-latter2"], { maxWaitTimeSec: 5 })
}

closeTelegram() {
    if (ClickToEny(["Android_backBtn"])) {
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
       Click, Left, 1
       Sleep, 200
    }
}