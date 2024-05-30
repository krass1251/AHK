#Include ..\Libs\Required-Libraries\Gdip_All.ahk


; Начальная инициализация GDI+
if !pToken := Gdip_Startup()
{
    MsgBox, Ошибка при запуске GDI+.
    ExitApp
}

Loop, 20  ; Цикл повторяется 20 раз
{
    Sleep, 5000
    scrn := Gdip_BitmapFromScreen(0 "|" 0 "|" A_ScreenWidth - 0 "|" A_ScreenHeight - 0)
    Gdip_SaveBitmapToFile(scrn, A_Now ".png")
    Gdip_DisposeImage(scrn)  ; Освобождает изображение после сохранения
}

; Завершение работы GDI+
Gdip_Shutdown(pToken)
ExitApp



