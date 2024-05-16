runEmulator(emulatorName) {
    WinClose, BlueStacks Multi Instance Manager
    Sleep, 300
    Run, "C:\Program Files\BlueStacks_nxt\HD-MultiInstanceManager.exe"

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
    return ClickToEny(["Android_close-confirm"], { sleepAfter: 1500 })
}

androidResetApps() {
    ClickToEny(["Android_resentApp"])
    ClickToEny(["Android_clearAll"])
}