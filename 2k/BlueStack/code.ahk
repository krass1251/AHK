Loop  ; Начало бесконечного цикла
    {
        ; Перебираем все элементы массива emulatorNames
        Loop, % emulatorNames.MaxIndex()
        {
            Sleep, 2000
            Send, {PrintScreen}
            LogStart("start emulator: " . emulatorNames[A_Index])
            emulatorName := emulatorNames[A_Index]

            Sleep, 1000
            Send, {PrintScreen}
            if (!runEmulator(emulatorName)) {
                continue
            }

            if (!runPostern()) { ; Run Proxy
                continue
            }

;            ClickAsist()
            hamster()

            closeEmulator()
        }
        Sleep, 60 * 60000
    }

