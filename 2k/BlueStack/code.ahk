Loop  ; Начало бесконечного цикла
    {
        ; Перебираем все элементы массива emulatorNames
        Loop, % emulatorNames.MaxIndex()
        {
            LogStart("start emulator: " . emulatorNames[A_Index])

            ; Run Emulator
            emulatorName := emulatorNames[A_Index]  ; Получаем значение текущего элемента массива
            WinClose, BlueStacks Multi Instance Manager
            Sleep, 300
            Run, "C:\Program Files\BlueStacks_nxt\HD-MultiInstanceManager.exe"

            ClickToEny(["bs_Search1", "bs_Search2"], { clickPosition: [-2, 0.5]})
            Send, ^a
            Send, {Backspace}
            SendRaw(emulatorName)
            ClickToEny(["BS_startEmulator"])
            ClickToEny(["Android_max-view"])
            WaithForEny(["prx_postern", "clickAsist", "telegramLogo2", "telegramLogo"])

            ; Run Proxy
            ClickToEny(["prx_postern"], { sleepAfter: 1000 })
            ClickToEny(["Android_homeBtn"])
            WaithForEny(["prx_active1", "prx_active2"])
;
;            ; Run and Setup Click Assistant
            ClickToEny(["clickAsist"], { sleepAfter: 500 })
;            ClickToEny(["clickAsist_rating-not"], 3)
            ClickToEny(["clickAsist_close"])
            ClickToEny(["clickAsist_StartService"])
            ClickToEny(["clickAsist_cancelAD"])
            ClickToEny(["clickAsist_saved-configs"])
            ClickToEny(["clickAsist_run-config-2"], { clickPosition: [0.95, 0.5]})
            ClickToEny(["clickAsist_hide-targets"])
            ClickToEny(["Android_homeBtn"])
;
;            ; Hamster Project
            ClickToEny(["Android_resentApp"])
            ClickToEny(["Android_clearAll"])
            ClickToEny(["telegramLogo2", "telegramLogo"])
            ClickToEny(["telegram_contact-cancel"], { maxWaitTimeSec: 5 })
            ClickToEny(["telegram-update-latter"], { maxWaitTimeSec: 5 })
            ClickToEny(["hamster_logo"])
            ClickToEny(["hamster_play"])
            ClickToEny(["hamster_thx"])
            ;Run colect items ?
;            ClickToEny(["clickAsist_play"])
;            Sleep, 30000







;            ; Make MemeFi Project
;            ClickToEny(["telegramLogo2", "telegramLogo"])
;            Sleep, 1000
;            ClickToEny(["telegram_memFI-logo", "telegram_memFI-logo2", "telegram_memFI-logo3", "telegram_memFI-logo-name4", "telegram_memFI-logo-name5"], 30)
;            ClickToEny(["telegram_Bot-menu"])
;            Sleep, 200
;            ClickToEny(["telegram_Bot-munu-play-command", "telegram_Bot-munu-play-command2"])
;            Sleep, 1000
;            ClickToEny(["telegram_play-in-bot2", "telegram_play-in-bot", "telegram_play-in-bot3", "telegram_play-in-bot4", "telegram_play-in-bot5"])
;            Sleep, 1500
;            WheelDown(3)
;            WaithForEny(["memFI_loaded1", "memFI_loaded2", "memFI_loaded3"])
;            WheelDown(3)
;            ClickToEny(["memFI_start-play", "memFI_start-play2"])
;            ClickToEny(["clickAsist_run-click-script", "clickAsist_run-click-script2"])
;            Sleep, 1 * 60000 ; 60000 = 1 min
;
;            ; Close Emulator
;            ClickToEny(["closePL", "closePL2", "closePL3"])
;            ClickToEny(["closeConfirm"])
;            Sleep, 1500

            ClickToEny(["Android_close"])
            ClickToEny(["Android_close-confirm"])

        }
        Sleep, 60 * 60000
    }

