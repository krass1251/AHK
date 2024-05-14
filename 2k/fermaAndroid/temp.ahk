#Include ..\..\Libs\Lib\getImageSize.ahk
#Include ..\..\Libs\json\JSON.ahk
#Include helpers\clipboard-helper.ahk
#Include helpers\click-helpers.ahk
#Include helpers\logger-helpers.ahk
#Include helpers\files-helpers.ahk
#Include variables\variables.ahk



if (emulators != "") ; Проверяем, что функция вернула не пустое значение
{
    ; Доступ к данным из объекта, например, имя пользователя
    MsgBox % emulators["name"]
}

