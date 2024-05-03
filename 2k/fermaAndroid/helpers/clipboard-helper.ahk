PasteText(Text) {
    Sleep, 150
    Clipboard := Text
    Sleep, 300
    SendInput, ^v
    Sleep, 150
}

SendRaw(text, delay = 50) {
    Sleep, % delay *2
    Loop, Parse, text
    {
        SendRaw % A_LoopField
        Sleep, % delay
    }
}

WheelDown(repeats = 1, delay = 50) {
    Loop, %repeats%
    {
        Click, WheelDown, 20
        Sleep, % delay
    }
}