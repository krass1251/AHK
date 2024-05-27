/* Written by Masonjar13

	GDI+ based alternative to ImageSearch command.
	
	Dependencies:
		Gdip_All
		Gdip_ImageSearch (included in this repository's Gdip_All)
-----------------

	Parameters:
---------------
	byRef out1: variable to store found x position
	
	byRef out2: variable to store found y position
	
	x1: top-left x coord of search area
	
	y1: top-left y coord of search area
	
	x2: bottom-right x coord of search area
	
	y2: bottom-right y coord of search area
	
	image: path to image file to search the screen for
	
	vari (optional): variation level (0-255)
	
	trans (optional): hexadecimal color value to treat as transparent
	
	direction (optional): direction to search
		Vertical preference:
		1 = top->left->right->bottom (matches top-left pixel)
		2 = bottom->left->right->top (matches bottom-left pixel)
		3 = bottom->right->left->top (matches bottom-right pixel)
		4 = top->right->left->bottom (matches top-right pixel)
		Horizontal preference:
		5 = left->top->bottom->right (matches top-left pixel) [default]
		6 = left->bottom->top->right (matches bottom-left pixel)
		7 = right->bottom->top->left (matches bottom-right pixel)
		8 = right->top->bottom->left (matches top-right pixel)
	
	debug (optional): save the screen image to the working directory
	
	return: 1 or 0, if match was found or not found
---------------

	Example:
------------
sErrLev:=imageSearchc(fx,fy,0,0,a_screenWidth,a_screenHeight,a_desktop "\image.png")
msgbox % sErrLev "`n" fx "x" fy
------------

*/

;#include ..\Required-Libraries\Gdip_All.ahk
#Include ..\..\Libs\Required-Libraries\Gdip_All.ahk

imageSearchc(byRef out1,byRef out2,x1,y1,x2,y2,image,vari:=0,trans:="",direction:=5,debug:=0){
	static ptok:=gdip_startup()
	imageB:=gdip_createBitmapFromFile(image)
	scrn:=gdip_bitmapfromscreen(x1 "|" y1 "|" x2 - x1 "|" y2 - y1)
	if(debug)
		gdip_saveBitmapToFile(scrn,a_now ".png")
	errorlev:=Gdip_ImageSearch(scrn,imageB,tempxy,0,0,0,0,vari,trans,direction)
	gdip_disposeImage(scrn)
	gdip_disposeImage(imageB)

	if (errorlev) {
		out:=strSplit(tempxy,"`,")
		out1:=out[1] + x1
		out2:=out[2] + y1
		return % errorlev
	}
	return 0
}

imageSearchc2(byRef out1, byRef out2, x1, y1, x2, y2, image, params := false) {
    scaleFactor := params.scaleFactor ? params.scaleFactor : 1.0
    vari := params.vari ? params.vari : 0
    trans := params.trans ? params.trans : ""
    direction := params.direction ? params.direction : 5
    debug := params.debug ? params.debug : 0

    static ptok := gdip_startup()

    ; Масштабируем изображение
    imageB := ScaleImage(image, scaleFactor)
    gdip_saveBitmapToFile(imageB,a_now ".png")
    if !imageB {
        MsgBox, Не удалось масштабировать изображение.
        return -1
    }

    ; Создаем скриншот области экрана
    scrn := gdip_bitmapfromscreen(x1 "|" y1 "|" x2 - x1 "|" y2 - y1)
    if (debug)
        gdip_saveBitmapToFile(scrn, a_now ".png")

    ; Выполняем поиск изображения
    errorlev := Gdip_ImageSearch(scrn, imageB, tempxy, 0, 0, 0, 0, vari, trans, direction)
    gdip_disposeImage(scrn)
    gdip_disposeImage(imageB)

    if (errorlev) {
        out := strSplit(tempxy, "`,")
        out1 := out[1] + x1
        out2 := out[2] + y1
        return errorlev
    }
    return 0
}

; Функция масштабирования изображения
ScaleImage(imagePath, scaleFactor) {
    ; Загрузить изображение для поиска
    pBitmap := Gdip_CreateBitmapFromFile(imagePath)
    gdip_saveBitmapToFile(pBitmap,a_now "2.png")
    if !pBitmap {
        MsgBox, Не удалось загрузить изображение.
        return
    }

    ; Получить размеры изображения
    width := Gdip_GetImageWidth(pBitmap)
    height := Gdip_GetImageHeight(pBitmap)

    ; Масштабирование изображения
    scaledWidth := width * scaleFactor / (1920/1024)
    scaledHeight := height * scaleFactor / (1080/768)

    ; Масштабировать изображение
    pScaledBitmap := Gdip_CreateBitmap(scaledWidth, scaledHeight)
    gdip_saveBitmapToFile(pScaledBitmap,"3.png")
    G := Gdip_GraphicsFromImage(pScaledBitmap)
    gdip_saveBitmapToFile(G,"4.png")
    Gdip_SetInterpolationMode(G, 7) ; Высококачественное масштабирование
    Gdip_DrawImage(G, pBitmap, 0, 0, scaledWidth, scaledHeight, width, height)

    gdip_saveBitmapToFile(pBitmap,"pBitmap.png")
    Gdip_DeleteGraphics(G)
    Gdip_DisposeImage(pBitmap)

    ; Возвращаем масштабированное изображение
    return pScaledBitmap
}

