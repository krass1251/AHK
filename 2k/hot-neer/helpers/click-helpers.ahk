ClickToEny(imageNames, maxWaitTimeSec := 5, sleepTime := 200) {
    startTime := A_TickCount  ; Инициализируем startTime перед началом цикла

    Loop
    {
        ; Создаем метку для использования с Break
        foundImage := false  ; Флаг, указывающий на то, было ли найдено изображение
        ; Проходим по всем элементам массива imageNames
        for index, imageName in imageNames
        {
            ; Поиск и клик картинки
            ImageSearch, FoundX, FoundY, 0, 0, %ScreenWidth%, %ScreenHeight%, images\%imageName%.png
            If !ErrorLevel
            {
                Click, %FoundX%, %FoundY%, 1
                foundImage := true  ; Устанавливаем флаг, что изображение было найдено
                Break  ; Прерываем цикл, если изображение найдено
            }
        }

        ; Проверяем, было ли найдено хотя бы одно изображение
        If (foundImage)
        {
            Break  ; Изображение найдено и кликнуто успешно
        }

        ; Проверяем, прошло ли 5 секунд с момента начала поиска
        currentTime := A_TickCount

        If ((currentTime - startTime) > (maxWaitTimeSec * 1000))
        {
            Break  ; Изображение не найдено в течение maxWaitTimeSec
        }

        Sleep, %sleepTime%
    }
}

WaithForEny(imageNames, sleepTime := 200) {
     Loop
     {
         ; Создаем метку для использования с Break
         foundImage := false  ; Флаг, указывающий на то, было ли найдено изображение
         ; Проходим по всем элементам массива imageNames
         for index, imageName in imageNames
         {
             ; Поиск и клик картинки
             ImageSearch, FoundX, FoundY, 0, 0, %ScreenWidth%, %ScreenHeight%, images\%imageName%.png
             If !ErrorLevel
             {
                 foundImage := true  ; Устанавливаем флаг, что изображение было найдено
                 Break  ; Прерываем цикл, если изображение найдено
             }
         }

         ; Проверяем, было ли найдено хотя бы одно изображение
         If (foundImage)
         {
            Break  ; Прерываем внешний цикл, если хотя бы одно изображение было найдено
         }

         Sleep, %sleepTime%
     }
 }