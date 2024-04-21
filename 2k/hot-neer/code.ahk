Loop  ; Начало бесконечного цикла
    {
        ; Перебираем все элементы массива emulatorNames
        Loop, % emulatorNames.MaxIndex()
        {
            emulatorName := emulatorNames[A_Index]  ; Получаем значение текущего элемента массива
            Run, "C:\LDPlayer\ldmutiplayer\dnmultiplayerex.exe"  ; Запускаем LDPlayer
            ClickToEny(["toClearSearch1", "toClearSearch2"], 1)
            ClickToEny(["ldSearch1", "ldSearch2", "ldSearch3"])
            PasteText(emulatorName)  ; Вызываем функцию для вставки текста
            ClickToEny(["closeEmulator"], 2)  ;хз что это
            ClickToEny(["ok"], 2)   ;хз что это
            ClickToEny(["startEmulator"])
            WaithForEny(["soudnPlusBtn", "keyboardBtn"])
            ClickToEny(["closeAdvertisment"], 10)
            ClickToEny(["postern"])
            WaithForEny(["proxiActive1", "proxiActive2"])
            ClickToEny(["homeBtn"])
            ClickToEny(["telegram"])
            ClickToEny(["neer"])
            ClickToEny(["openWallet"]) ;todo 1) add black themes 2) add claim now btn if storage full notification
            ;maybe scrool to bottom?
            ClickToEny(["storage"])
            ClickToEny(["claimHOT"])
            WaithForEny(["claimed"])
            ClickToEny(["closePL"])
            ClickToEny(["closeConfirm"])
        }
        Random, randomNumber, 7200000, 7600000  ; 2h - 2.10
        Sleep, randomNumber
    }

