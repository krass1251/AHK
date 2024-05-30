#Include ..\..\Libs\Lib\getImageSize.ahk
#Include ..\..\Libs\Lib\imageSearchc.ahk
#Include ..\..\Libs\Required-Libraries\Gdip_All.ahk
;#Include ..\..\Libs\json\JSON.ahk

#Include helpers\clipboard-helper.ahk
#Include helpers\click-helpers.ahk
#Include helpers\logger-helpers.ahk
#Include helpers\files-helpers.ahk

#Include variables\variables.ahk
;
;#Include parts\bsEmulator.ahk
;#Include parts\proxy.ahk
;#Include parts\clickAsist.ahk
;
;#Include projects\hamster.ahk

;#Include code.ahk

;ClickToEny(["test\test_ahk"], { clickPosition: [0, 0]})
Sleep, 10000
scrn:=gdip_bitmapfromscreen(0 "|" 0 "|" A_ScreenWidth - 0 "|" A_ScreenHeight - 0)
gdip_saveBitmapToFile(scrn,a_now ".png")



;; Инициализация GDI+
;if !pToken := Gdip_Startup()
;{
;    MsgBox, Ошибка инициализации GDI+.
;    ExitApp
;}
;
;; Пример использования функции
;imageName := "test\test_ahk"
;imagePath:= imagePath:= "images\" . imageName . ".png"
;;scaleFactorX := 1920/1024
;;scaleFactorY := 1080/768
;scaleFactorX := 1
;scaleFactorY := 1
;;pScaledBitmap := ScaleImage(imagePath, scaleFactorX, scaleFactorY)
;
;; Проверяем, удалось ли создать масштабированное изображение
;;if !pScaledBitmap
;;{
;;    MsgBox, can't scale image.
;;}
;;else
;;{
;
;sErrLev := imageSearchc22(FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, imagePath)
;MsgBox, sErrLev: %sErrLev% FoundX: %FoundX% FoundY: %FoundY%
;CoordMode, Mouse, Screen
;Click, %FoundX%, %FoundX%, 0
;    ; Ваш код здесь для работы с pScaledBitmap
;;}
;
;; Очистка ресурсов
;;Gdip_DisposeImage(pScaledBitmap)
;;Gdip_Shutdown(pToken)
;
;; Функция масштабирования изображения
;ScaleImage(imagePath, scaleFactorX, scaleFactorY)
;{
;    ; Загрузить изображение для поиска
;    pBitmap := Gdip_CreateBitmapFromFile(imagePath)
;    if !pBitmap
;    {
;        MsgBox, can't find image.
;        return
;    }
;
;    ; Получить размеры изображения
;    width := Gdip_GetImageWidth(pBitmap)
;    height := Gdip_GetImageHeight(pBitmap)
;
;    ; Масштабирование изображения
;    scaledWidth := width * scaleFactorX
;    scaledHeight := height * scaleFactorY
;
;    ; Масштабировать изображение
;    pScaledBitmap := Gdip_CreateBitmap(scaledWidth, scaledHeight)
;    G := Gdip_GraphicsFromImage(pScaledBitmap)
;    Gdip_SetInterpolationMode(G, 7) ; Высококачественное масштабирование
;    Gdip_DrawImage(G, pBitmap, 0, 0, scaledWidth, scaledHeight, width, height)
;    Gdip_DeleteGraphics(G)
;    Gdip_DisposeImage(pBitmap)
;
;    ; Возвращаем масштабированное изображение
;    return pScaledBitmap
;}
;
;
;imageSearchc22(byRef out1,byRef out2,x1,y1,x2,y2,image,vari:=0,trans:="",direction:=5,debug:=0){
;	static ptok:=gdip_startup()
;	imageB:=gdip_createBitmapFromFile(image)
;	scrn:=gdip_bitmapfromscreen(x1 "|" y1 "|" x2 - x1 "|" y2 - y1)
;	if(1)
;		gdip_saveBitmapToFile(scrn,a_now ".png")
;	errorlev:=Gdip_ImageSearch(scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
;	gdip_disposeImage(scrn)
;	gdip_disposeImage(imageB)
;
;	if (errorlev) {
;		out:=strSplit(tempxy,"`,")
;		out1:=out[1] + x1
;		out2:=out[2] + y1
;		return % errorlev
;	}
;	return 0
;}


;MsgBox, Done
;Click, 512, 384, 0