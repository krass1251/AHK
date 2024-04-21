Loop  ; Начало бесконечного цикла
    {
        ; Перебираем все элементы массива emulatorNames
        Loop, % emulatorNames.MaxIndex()
        {
            LogStart("start emulator: " . emulatorNames[A_Index])

            ; Run Emulator
            emulatorName := emulatorNames[A_Index]  ; Получаем значение текущего элемента массива
            Run, "C:\LDPlayer\ldmutiplayer\dnmultiplayerex.exe"  ; Запускаем LDPlayer
            ClickToEny(["toClearSearch1", "toClearSearch2"], 2)
            ClickToEny(["ldSearch1", "ldSearch2", "ldSearch3"])
            SendRaw(emulatorName)

            ; Close Previos Emulator if it Still Open
            ClickToEny(["closeEmulator"], 2)
            ClickToEny(["ok"], 2)

            ClickToEny(["startEmulator"])
            WaithForEny(["soudnPlusBtn", "keyboardBtn"])
            ClickToEny(["closeAdvertisment"], 10)
            ClickToEny(["postern"])
            WaithForEny(["proxiActive1", "proxiActive2", "proxiActive3"])
            ClickToEny(["Android_homeBtn"])

            ; Run and Setup Click Assistant
            ClickToEny(["clickAsist"])
            ClickToEny(["clickAsist_rating-not"], 3)
            ClickToEny(["clickAsist_close-battery-warning"])
            ClickToEny(["clickAsist_RunService"])
            ClickToEny(["clickAsist_cancelAD"])
            ClickToEny(["clickAsist_saved-configs" ,"clickAsist_saved-configs2"])
            ClickToEny(["clickAsist_search"])
            Sleep, 150
            SendRaw("help")
            Sleep, 150
            ClickToEny(["clickAsist_run-config"])
            Sleep, 400
            ClickToEny(["clickAsist_hide-targets"])
            ClickToEny(["Android_homeBtn"])

            ; Make MemeFi Project
            ClickToEny(["telegramLogo", "telegramLogo2"])
            Sleep, 1000
            ClickToEny(["telegram_memFI-logo", "telegram_memFI-logo2", "telegram_memFI-logo3", "telegram_memFI-logo-name4", "telegram_memFI-logo-name5"], 30)
            ClickToEny(["telegram_Bot-menu"])
            Sleep, 200
            ClickToEny(["telegram_Bot-munu-play-command", "telegram_Bot-munu-play-command2"])
            Sleep, 1000
            ClickToEny(["telegram_play-in-bot2", "telegram_play-in-bot", "telegram_play-in-bot3", "telegram_play-in-bot4", "telegram_play-in-bot5"])
            Sleep, 1500
            WheelDown(3)
            WaithForEny(["memFI_loaded1", "memFI_loaded2", "memFI_loaded3"])
            WheelDown(3)
            ClickToEny(["memFI_start-play", "memFI_start-play2"])
            ClickToEny(["clickAsist_run-click-script", "clickAsist_run-click-script2"])
            Sleep, 1 * 60000 ; 60000 = 1 min

            ; Close Emulator
            ClickToEny(["closePL", "closePL2", "closePL3"])
            ClickToEny(["closeConfirm"])
            Sleep, 1500
        }
        Sleep, 60 * 60000
    }

