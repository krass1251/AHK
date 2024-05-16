/*
ClickToEny() Parameters:
- imageNames (Array of Strings): Names of the images to search for. ["telegramLogo", "telegramLogo2"]
- params (Object, Optional): Customization options:
    - maxWaitTimeSec (Integer): Max wait time in seconds (default: 10).
    - sleepTime (Integer): Time between searches in milliseconds (default: 200).
    - clickPosition (Array of Two Integers): Click position within the image as fractions (default: { clickPosition: [0.5, 0.5]} ):
        - Left Top: [0, 0]
        - Right Top: [1, 0]
        - Left Bottom: [0, 1]
        - Right Bottom: [1, 1]
        - Center [0.5, 0.5]
        - Also you can click 2x Top from image [0.5, -2] or 2x Bottom from image [0.5, 2]
        - Also you can click 2x Left from image [-2, 0.5] or 2x Right from image [2, 0.5]
*/

ClickToEny(imageNames, params := false) {
    startTime := A_TickCount

    maxWaitTimeSec := params.maxWaitTimeSec ? params.maxWaitTimeSec : 10
    sleepTime := params.sleepTime ? params.sleepTime : 200
    clickPosition := params.clickPosition ? params.clickPosition : [0.5, 0.5]

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
                CenterX := FoundX + iSize.width * clickPosition[1]
                CenterY := FoundY + iSize.height * clickPosition[2]

                Click, %CenterX%, %CenterY%, 0
                Sleep, 200
                Click, Left, 1
                Sleep, 200
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

WaithForEny(imageNames, params := false) {
    startTime := A_TickCount  ; Инициализируем startTime перед началом цикла

    maxWaitTimeSec := params.maxWaitTimeSec ? params.maxWaitTimeSec : 30000
    sleepTime := params.sleepTime ? params.sleepTime : 200

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