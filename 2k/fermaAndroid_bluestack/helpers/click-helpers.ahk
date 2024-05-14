ClickToEny(imageNames, maxWaitTimeSec := 10, sleepTime := 200) {
    startTime := A_TickCount

    if(IS_DEBUG_MODE) {
        StartFindEny("ClickToEny", imageNames)
    }

    Loop
    {
        foundImage := false
        for index, imageName in imageNames
        {
            ; Поиск и клик картинки
            imagePath:= "images\" . imageName . ".png"
            ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %imagePath%
            If !ErrorLevel
            {
                ; Поиск центра картинки
                iSize:=getImageSize(imagePath)
                CenterX := FoundX + iSize.width / 2
                CenterY := FoundY + iSize.height / 2

                Click, %CenterX%, %CenterY%, 0
                Sleep, 200
                Click, Left, 1
                foundImage := true  ; Устанавливаем флаг, что изображение было найдено
                Break  ; Прерываем цикл, если изображение найдено
            }
        }

        ; Проверяем, было ли найдено хотя бы одно изображение
        If (foundImage)
        {
            OkFindEny("ClickToEny", imageNames)
            Sleep, 100
            Return true  ; Изображение найдено и кликнуто успешно
        }

        ; Проверяем, прошло ли Х секунд с момента начала поиска
        currentTime := A_TickCount

        If ((currentTime - startTime) > (maxWaitTimeSec * 1000))
        {
            ErrorFindEny("ClickToEny", imageNames)
            Return false  ; Изображение не найдено в течение maxWaitTimeSec
        }

        Sleep, %sleepTime%
    }
}

WaithForEny(imageNames, maxWaitTimeSec := 20, sleepTime := 200) {
    startTime := A_TickCount  ; Инициализируем startTime перед началом цикла

    if(IS_DEBUG_MODE) {
        StartFindEny("WaithForEny", imageNames)
    }

     Loop
     {
         ; Создаем метку для использования с Break
         foundImage := false  ; Флаг, указывающий на то, было ли найдено изображение
         ; Проходим по всем элементам массива imageNames
         for index, imageName in imageNames
         {
             ; Поиск и клик картинки
             ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, images\%imageName%.png
             If !ErrorLevel
             {
                 foundImage := true  ; Устанавливаем флаг, что изображение было найдено
                 Break  ; Прерываем цикл, если изображение найдено
             }
         }

         ; Проверяем, было ли найдено хотя бы одно изображение
         If (foundImage)
         {
            OkFindEny("WaithForEny", imageNames)
            Return true  ; Прерываем внешний цикл, если хотя бы одно изображение было найдено
         }

        ; Проверяем, прошло ли 5 секунд с момента начала поиска
        currentTime := A_TickCount

        If ((currentTime - startTime) > (maxWaitTimeSec * 1000))
        {
            ErrorFindEny("WaithForEny", imageNames)
            Return false  ; Изображение не найдено в течение maxWaitTimeSec
        }

         Sleep, %sleepTime%
     }
 }