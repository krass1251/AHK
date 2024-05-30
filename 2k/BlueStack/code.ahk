Loop  ; Начало бесконечного цикла
{
    ; Перебираем все элементы массива emulatorNames
    Loop, % emulatorNames.MaxIndex()
    {
        LogStart("start emulator: " . emulatorNames[A_Index])
        emulatorName := emulatorNames[A_Index]

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

