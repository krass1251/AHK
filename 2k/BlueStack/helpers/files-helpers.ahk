LoadJsonFromFile(filePath) {
    if !FileExist(filePath)
    {
;        MsgBox, File not found: %filePath%
;        LogError("LoadJsonFromFile", [filePath])
        return
    }

    ; Чтение файла
    FileRead, jsonString, %filePath%
    if ErrorLevel ; Проверка на наличие ошибок при чтении файла
    {
;        MsgBox, Can't read the file: %filePath%
        return
    }

    ; Загрузка JSON из строки
    jsonObject := JSON.Load(jsonString)
    if (jsonObject = "") ; Проверка на наличие ошибок при загрузке JSON
    {
;        MsgBox, cant reade the JSON sting from the file: %filePath%
        return
    }

    ; Возвращаем объект, созданный из JSON-строки
    return jsonObject
}