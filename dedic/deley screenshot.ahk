#Include ..\..\Libs\Required-Libraries\Gdip_All.ahk

Sleep, 5000
scrn:=gdip_bitmapfromscreen(0 "|" 0 "|" A_ScreenWidth - 0 "|" A_ScreenHeight - 0)
gdip_saveBitmapToFile(scrn,a_now ".png")