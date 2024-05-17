#Include ..\..\Libs\Lib\getImageSize.ahk
#Include ..\..\Libs\json\JSON.ahk

#Include helpers\clipboard-helper.ahk
#Include helpers\click-helpers.ahk
#Include helpers\logger-helpers.ahk
#Include helpers\files-helpers.ahk

#Include variables\variables.ahk

#Include parts\bsEmulator.ahk
#Include parts\proxy.ahk
#Include parts\clickAsist.ahk

#Include projects\hamster.ahk

ClickToEny(["Android_clearAll6", "Android_clearAll", "Android_clearAll2", "Android_clearAll3", "Android_clearAll4", "Android_clearAll5"], { maxWaitTimeSec: 30, variation: 50 })
