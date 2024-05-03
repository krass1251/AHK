; For the text with several lines
InsertText(Text) {
    ClipboardOld := ClipboardAll
    Clipboard := Text
    SendInput, ^v
    Sleep, 100
    Clipboard := ClipboardOld
}


TextToInsertCRTS =
(

You are a skilled Frontend software engineer conducting a code review for the following Typescript code.
Please provide a comprehensive code review for the given code. Consider the following:
- Code structure and organization.
- Correctness and efficiency of the algorithm.
- Proper usage of JavaScript best practices.
- Potential bugs or vulnerabilities.
- Suggestions for improvement.
Provide your review in the form of corrected code, incorporating any necessary changes to address the points mentioned above.
In the code, before the changed fragments, leave comments about what was changed and why.
Then justify your changes, present your arguments in Russian.
)

TextToInsertCRJS =
(

 You are a skilled Frontend software engineer conducting a code review for the following JavaScript code.
 Please provide a comprehensive code review for the given code. Consider the following:
 - Code structure and organization.
 - Correctness and efficiency of the algorithm.
 - Proper usage of JavaScript best practices.
 - Potential bugs or vulnerabilities.
 - Suggestions for improvement.
 Provide your review in the form of corrected code, incorporating any necessary changes to address the points mentioned above.
 In the code, before the changed fragments, leave comments about what was changed and why.
 Then justify your changes, present your arguments in Russian.
)

TextToInsertReg =
(

напиши регулярное выражение на Javascript, которое из строки берет

Вот пример
строка:
результат:

отвечай в роли Senior Javascript developer
)

TextToInsertFixTs =
 (

 help to fix the error:

 in the line:

 I want you to act as a Senior TypeScript developer.
 )


::cr ::
    global TextToInsertCRTS
    InsertText(TextToInsertCRTS)
return
::ск ::
    global TextToInsertCRTS
    InsertText(TextToInsertCRTS)
return



::crjs ::
    global TextToInsertCRJS
    InsertText(TextToInsertCRJS)
return
::скоы ::
    global TextToInsertCRJS
    InsertText(TextToInsertCRJS)
return



::reg ::
    global TextToInsertReg
    InsertText(TextToInsertReg)
return
::куп ::
    global TextToInsertReg
    InsertText(TextToInsertReg)
return


::fixts ::
    global TextToInsertFixTs
    InsertText(TextToInsertFixTs)
return
::ашчеы ::
    global TextToInsertFixTs
    InsertText(TextToInsertFixTs)
return

::htf ::How to fix it?
::реа ::How to fix it?

::ipq ::Improve quality and readability of the code
::шзй ::Improve quality and readability of the code



::sts ::I want you to act as a Senior TypeScript developer.
::ыеы ::I want you to act as a Senior TypeScript developer.

::js ::JavaScript
::оы ::JavaScript

::ts ::TypeScript
::еы ::TypeScript

::sjs ::I want you to act as a Senior JavaScript developer.
::соы ::I want you to act as a Senior JavaScript developer.

::sahk ::I want you to act as a Senior AutoHotKey developer.
::ыфрл ::I want you to act as a Senior AutoHotKey developer.

::сфрл ::Отвечай в роли Senior auto hot key разработчика.
::cahk ::Отвечай в роли Senior auto hot key разработчика.

::srts ::I want you to act as a Senior React TypeScript developer.
::ыкеы ::I want you to act as a Senior React TypeScript developer.

::sa ::I want you to act as a Senior Angular developer.
::ыф ::I want you to act as a Senior Angular developer.

::sqa ::I want you to act as a Senior Quality Assurance engineer.
::ыйф ::I want you to act as a Senior Quality Assurance engineer.

::sqa ::I want you to act as a Senior Quality Assurance engineer.
::ыйф ::I want you to act as a Senior Quality Assurance engineer.

::сйф ::отвечай в роли Senior Quality Assurance инженера.
::sqa ::отвечай в роли Senior Quality Assurance инженера.

::сртс ::отвечай в роли Senior React TypeScript разработчика.
::стс ::отвечай в роли Senior TypeScript разработчика.

::са ::отвечай в роли Senior Angular разработчика.
::cf ::отвечай в роли Senior Angular разработчика.

::срджс ::отвечай в роли Senior React JavaScript разработчика.
::сджс ::отвечай в роли Senior JavaScript разработчика.

::ipmsu :: Help me enhance the quality of my message. Please perform a spell check, fix any grammar mistakes, and make the message easy to read and understand:

::ipms :: Help me enhance the quality of my message. Please perform a spell check, fix any grammar mistakes:
::шзьы :: Help me enhance the quality of my message. Please perform a spell check, fix any grammar mistakes:

::ce :: Correct the error in my text:
::су :: Correct the error in my text:

::usw :: Use only simple words and phrases
::usw :: Use only simple words and phrases

::ipcd :: improve the code using JavaScript best practices. I want you to act as a Senior JavaScript developer.
::шзсв :: improve the code using JavaScript best practices. I want you to act as a Senior JavaScript developer.

::ipnm :: improve the variables naming using JavaScript best practices. I want you to act as a Senior JavaScript developer.
::шзть :: improve the variables naming using JavaScript best practices. I want you to act as a Senior JavaScript developer.

::ipcdts :: improve the code using TypeScript best practices. I want you to act as a Senior TypeScript developer.
::шзсвеы :: improve the code using TypeScript best practices. I want you to act as a Senior TypeScript developer.

::англ ::переведи на английский:
::fyuk ::переведи на английский:

::срус ::переведи свое сообщение на русский
::chec ::переведи свое сообщение на русский

::wr ::window.render ? window.render++ : window.render = 1; console.log('render', window.render);
