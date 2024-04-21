^!c::
{
  ; Скопировать выделенный текст
  Send, ^c
  ClipWait

  ; Закодировать текст для использования в URL
  clipboard := UriEncode(Clipboard)

  ; Открыть Google Translate в браузере по умолчанию
  Run, https://translate.google.com/?sl=auto&tl=en&text=%clipboard%&op=translate
}

UriEncode(string) {
  return StrReplace(string, " ", "%20")
}