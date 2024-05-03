LoadJsonFromFile(filePath) {
    ; Чтение файла
    FileRead, jsonString, %filePath%
    if ErrorLevel ; Проверка на наличие ошибок при чтении файла
    {
        MsgBox, Не удалось прочитать файл: %filePath%
        return
    }

    ; Загрузка JSON из строки
    jsonObject := JsonLoad(jsonString)
    if (jsonObject = "") ; Проверка на наличие ошибок при загрузке JSON
    {
        MsgBox, Не удалось загрузить JSON из строки
        return
    }

    ; Возвращаем объект, созданный из JSON-строки
    return jsonObject
}