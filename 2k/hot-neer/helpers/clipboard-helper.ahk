PasteText(Text) {
    ClipboardOld := ClipboardAll
    Clipboard := Text
    SendInput, ^v
    Sleep, 100
    Clipboard := ClipboardOld
}
