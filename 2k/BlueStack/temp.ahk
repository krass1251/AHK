#Include ..\..\Libs\Lib\getImageSize.ahk
#Include ..\..\Libs\Lib\imageSearchc.ahk
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
Sleep, 2000
;ClickToEny(["bs_Search1", "bs_Search2"], { clickPosition: [-2, 0.5]})
CoordMode, Mouse, Screen
Click, 0, 0, 0