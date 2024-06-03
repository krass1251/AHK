Loop  ; Начало бесконечного цикла
{
    ; Перебираем все элементы массива emulators
    Loop, % emulators.MaxIndex()
    {
        emulator := emulators[A_Index]

        LogStart("start emulator: " . emulator.name)

        if (emulator.isSkipMe) {
            continue
        }

        if (!runEmulator(emulator.name)) {
            continue
        }

        if (!runPostern()) { ; Run Proxy
            continue
        }

;        ClickAsist()

        makeProjects(emulator.projects)

        ; todo send the report to telegram
        closeEmulator()
    }
    Sleep, 60 * 60000
}

