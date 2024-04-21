

^!z:: ; The hotkey is set to Ctrl + Alt + Z, you can change this to whatever you prefer.
global running := true
delay := 100 ; Time delay variable in milliseconds
SetKeyDelay, %delay%

Loop
{
     if (!running)
        continue
    Send, ^c ; This will simulate pressing Ctrl + C
    Sleep, %delay% ; This will pause the script for delay milliseconds
    Send, !{Tab} ; This will simulate pressing Alt + Tab
    Sleep, %delay% ; This will pause the script for delay milliseconds
    Send, ^v ; This will simulate pressing Ctrl + V
    Sleep, %delay% ; This will pause the script for delay milliseconds
    clipboard := "`r`n" ; This will set the clipboard to carriage return and newline, representing a Windows-style line break
    Sleep, %delay% ; This will pause the script for delay milliseconds
    Send, ^v ; This will simulate pressing Ctrl + V
    Sleep, %delay% ; This will pause the script for delay milliseconds
    Send, !{Tab} ; This will simulate pressing Alt + Tab
    Sleep, %delay% ; This will pause the script for delay milliseconds
    Send, {Down} ; This will simulate pressing Down arrow key
}


RButton::running := false ; Stops the script when you click the right mouse button

return
