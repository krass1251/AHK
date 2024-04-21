UpdateLayeredWindow(hwnd,hdc,x="",y="",w="",h="",Alpha=255){
if((x!="")&&(y!=""))
VarSetCapacity(pt,8),NumPut(x,pt,0,"UInt"),NumPut(y,pt,4,"UInt")
if(w="")||(h="")
WinGetPos,,,w,h,ahk_id %hwnd%
return DllCall("UpdateLayeredWindow","UPtr",hwnd,"UPtr",0,"UPtr",((x="")&&(y=""))?0:&pt,"int64*",w|h<<32,"UPtr",hdc,"int64*",0,"uint",0,"UInt*",Alpha<<16|1<<24,"uint",2)
}
BitBlt(ddc,dx,dy,dw,dh,sdc,sx,sy,Raster=""){
return DllCall("gdi32\BitBlt","UPtr",dDC,"int",dx,"int",dy,"int",dw,"int",dh,"UPtr",sDC,"int",sx,"int",sy,"uint",Raster?Raster:0x00CC0020)
}
StretchBlt(ddc,dx,dy,dw,dh,sdc,sx,sy,sw,sh,Raster=""){
return DllCall("gdi32\StretchBlt","UPtr",ddc,"int",dx,"int",dy,"int",dw,"int",dh,"UPtr",sdc,"int",sx,"int",sy,"int",sw,"int",sh,"uint",Raster?Raster:0x00CC0020)
}
SetStretchBltMode(hdc,iStretchMode=4){
return DllCall("gdi32\SetStretchBltMode","UPtr",hdc,"int",iStretchMode)
}
SetImage(hwnd,hBitmap){
SendMessage,0x172,0x0,hBitmap,,ahk_id %hwnd%
E:=ErrorLevel
DeleteObject(E)
return E
}
SetSysColorToControl(hwnd,SysColor=15){
WinGetPos,,,w,h,ahk_id %hwnd%
bc:=DllCall("GetSysColor","Int",SysColor,"UInt")
pBrushClear:=Gdip_BrushCreateSolid(0xff000000|(bc>>16|bc&0xff00|(bc&0xff)<<16))
pBitmap:=Gdip_CreateBitmap(w,h),G:=Gdip_GraphicsFromImage(pBitmap)
Gdip_FillRectangle(G,pBrushClear,0,0,w,h)
hBitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
SetImage(hwnd,hBitmap)
Gdip_DeleteBrush(pBrushClear)
Gdip_DeleteGraphics(G),Gdip_DisposeImage(pBitmap),DeleteObject(hBitmap)
return 0
}
Gdip_BitmapFromScreen(Screen=0,Raster=""){
if(Screen=0)
{
Sysget,x,76
Sysget,y,77
Sysget,w,78
Sysget,h,79
}
else if(SubStr(Screen,1,5)="hwnd:")
{
Screen:=SubStr(Screen,6)
if !WinExist("ahk_id " Screen)
return -2
WinGetPos,,,w,h,ahk_id %Screen%
x:=y:=0
hhdc:=GetDCEx(Screen,3)
}
else if(Screen&1!="")
{
Sysget,M,Monitor,%Screen%
x:=MLeft,y:=MTop,w:=MRight-MLeft,h:=MBottom-MTop
}
else
{
StringSplit,S,Screen,|
x:=S1,y:=S2,w:=S3,h:=S4
}
if(x="")||(y="")||(w="")||(h="")
return -1
chdc:=CreateCompatibleDC(),hbm:=CreateDIBSection(w,h,chdc),obm:=SelectObject(chdc,hbm),hhdc:=hhdc?hhdc:GetDC()
BitBlt(chdc,0,0,w,h,hhdc,x,y,Raster)
ReleaseDC(hhdc)
pBitmap:=Gdip_CreateBitmapFromHBITMAP(hbm)
SelectObject(chdc,obm),DeleteObject(hbm),DeleteDC(hhdc),DeleteDC(chdc)
return pBitmap
}
Gdip_BitmapFromHWND(hwnd){
WinGetPos,,,Width,Height,ahk_id %hwnd%
hbm:=CreateDIBSection(Width,Height),hdc:=CreateCompatibleDC(),obm:=SelectObject(hdc,hbm)
PrintWindow(hwnd,hdc)
pBitmap:=Gdip_CreateBitmapFromHBITMAP(hbm)
SelectObject(hdc,obm),DeleteObject(hbm),DeleteDC(hdc)
return pBitmap
}
CreateRectF(ByRef RectF,x,y,w,h){
VarSetCapacity(RectF,16)
NumPut(x,RectF,0,"float"),NumPut(y,RectF,4,"float"),NumPut(w,RectF,8,"float"),NumPut(h,RectF,12,"float")
}
CreateRect(ByRef Rect,x,y,w,h){
VarSetCapacity(Rect,16)
NumPut(x,Rect,0,"uint"),NumPut(y,Rect,4,"uint"),NumPut(w,Rect,8,"uint"),NumPut(h,Rect,12,"uint")
}
CreateSizeF(ByRef SizeF,w,h){
VarSetCapacity(SizeF,8)
NumPut(w,SizeF,0,"float"),NumPut(h,SizeF,4,"float")     
}
CreatePointF(ByRef PointF,x,y){
VarSetCapacity(PointF,8)
NumPut(x,PointF,0,"float"),NumPut(y,PointF,4,"float")     
}
CreateDIBSection(w,h,hdc="",bpp=32,ByRef ppvBits=0){
hdc2:=hdc?hdc:GetDC()
VarSetCapacity(bi,40,0)
NumPut(w,bi,4,"uint"),NumPut(h,bi,8,"uint"),NumPut(40,bi,0,"uint"),NumPut(1,bi,12,"ushort"),NumPut(0,bi,16,"uInt"),NumPut(bpp,bi,14,"ushort")
hbm:=DllCall("CreateDIBSection","UPtr",hdc2,"UPtr",&bi,"uint",0,"UPtr*",ppvBits,"UPtr",0,"uint",0,Ptr)
if !hdc
ReleaseDC(hdc2)
return hbm
}
PrintWindow(hwnd,hdc,Flags=0){
return DllCall("PrintWindow","UPtr",hwnd,"UPtr",hdc,"uint",Flags)
}
DestroyIcon(hIcon){
return DllCall("DestroyIcon","UPtr",hIcon)
}
PaintDesktop(hdc){
return DllCall("PaintDesktop","UPtr",hdc)
}
CreateCompatibleBitmap(hdc,w,h){
return DllCall("gdi32\CreateCompatibleBitmap","UPtr",hdc,"int",w,"int",h)
}
CreateCompatibleDC(hdc=0){
   return DllCall("CreateCompatibleDC","UPtr",hdc)
}
SelectObject(hdc,hgdiobj){
return DllCall("SelectObject","UPtr",hdc,"UPtr",hgdiobj)
}
DeleteObject(hObject){
   return DllCall("DeleteObject","UPtr",hObject)
}
GetDC(hwnd=0){
return DllCall("GetDC","UPtr",hwnd)
}
GetDCEx(hwnd,flags=0,hrgnClip=0){
return DllCall("GetDCEx","UPtr",hwnd,"UPtr",hrgnClip,"int",flags)
}
ReleaseDC(hdc,hwnd=0){
return DllCall("ReleaseDC","UPtr",hwnd,"UPtr",hdc)
}
DeleteDC(hdc){
return DllCall("DeleteDC","UPtr",hdc)
}
Gdip_LibraryVersion(){
return 1.45
}
Gdip_LibrarySubVersion(){
return 1.47
}
Gdip_BitmapFromBRA(ByRef BRAFromMemIn,File,Alternate=0){
Static FName="ObjRelease"
if !BRAFromMemIn
return -1
Loop,Parse,BRAFromMemIn,`n
{
if(A_Index=1)
{
StringSplit,Header,A_LoopField,|
if(Header0!=4||Header2!="BRA!")
return -2
}
else if(A_Index=2)
{
StringSplit,Info,A_LoopField,|
if(Info0!=3)
return -3
}
else
break
}
if !Alternate
StringReplace,File,File,\,\\,All
RegExMatch(BRAFromMemIn,"mi`n)^" (Alternate?File "\|.+?\|(\d+)\|(\d+)":"\d+\|" File "\|(\d+)\|(\d+)") "$",FileInfo)
if !FileInfo
return -4
hData:=DllCall("GlobalAlloc","uint",2,"UPtr",FileInfo2,Ptr)
pData:=DllCall("GlobalLock","UPtr",hData,Ptr)
DllCall("RtlMoveMemory","UPtr",pData,"UPtr",&BRAFromMemIn+Info2+FileInfo1,"UPtr",FileInfo2)
DllCall("GlobalUnlock","UPtr",hData)
DllCall("ole32\CreateStreamOnHGlobal","UPtr",hData,"int",1,"UPtr*",pStream)
DllCall("gdiplus\GdipCreateBitmapFromStream","UPtr",pStream,"UPtr*",pBitmap)
if(A_PtrSize)
%FName%(pStream)
Else
DllCall(NumGet(NumGet(1*pStream)+8),"uint",pStream)
return pBitmap
}
Gdip_DrawRectangle(pGraphics,pPen,x,y,w,h){
return DllCall("gdiplus\GdipDrawRectangle","UPtr",pGraphics,"UPtr",pPen,"float",x,"float",y,"float",w,"float",h)
}
Gdip_DrawRoundedRectangle(pGraphics,pPen,x,y,w,h,r){
Gdip_SetClipRect(pGraphics,x-r,y-r,2*r,2*r,4)
Gdip_SetClipRect(pGraphics,x+w-r,y-r,2*r,2*r,4)
Gdip_SetClipRect(pGraphics,x-r,y+h-r,2*r,2*r,4)
Gdip_SetClipRect(pGraphics,x+w-r,y+h-r,2*r,2*r,4)
E:=Gdip_DrawRectangle(pGraphics,pPen,x,y,w,h)
Gdip_ResetClip(pGraphics)
Gdip_SetClipRect(pGraphics,x-(2*r),y+r,w+(4*r),h-(2*r),4)
Gdip_SetClipRect(pGraphics,x+r,y-(2*r),w-(2*r),h+(4*r),4)
Gdip_DrawEllipse(pGraphics,pPen,x,y,2*r,2*r)
Gdip_DrawEllipse(pGraphics,pPen,x+w-(2*r),y,2*r,2*r)
Gdip_DrawEllipse(pGraphics,pPen,x,y+h-(2*r),2*r,2*r)
Gdip_DrawEllipse(pGraphics,pPen,x+w-(2*r),y+h-(2*r),2*r,2*r)
Gdip_ResetClip(pGraphics)
return E
}
Gdip_DrawEllipse(pGraphics,pPen,x,y,w,h){
return DllCall("gdiplus\GdipDrawEllipse","UPtr",pGraphics,"UPtr",pPen,"float",x,"float",y,"float",w,"float",h)
}
Gdip_DrawBezier(pGraphics,pPen,x1,y1,x2,y2,x3,y3,x4,y4){
return DllCall("gdiplus\GdipDrawBezier","UPtr",pgraphics,"UPtr",pPen,"float",x1,"float",y1,"float",x2,"float",y2,"float",x3,"float",y3,"float",x4,"float",y4)
}
Gdip_DrawArc(pGraphics,pPen,x,y,w,h,StartAngle,SweepAngle){
return DllCall("gdiplus\GdipDrawArc","UPtr",pGraphics,"UPtr",pPen,"float",x,"float",y,"float",w,"float",h,"float",StartAngle,"float",SweepAngle)
}
Gdip_DrawPie(pGraphics,pPen,x,y,w,h,StartAngle,SweepAngle){
return DllCall("gdiplus\GdipDrawPie","UPtr",pGraphics,"UPtr",pPen,"float",x,"float",y,"float",w,"float",h,"float",StartAngle,"float",SweepAngle)
}
Gdip_DrawLine(pGraphics,pPen,x1,y1,x2,y2){
return DllCall("gdiplus\GdipDrawLine","UPtr",pGraphics,"UPtr",pPen,"float",x1,"float",y1,"float",x2,"float",y2)
}
Gdip_DrawLines(pGraphics,pPen,Points){
StringSplit,Points,Points,|
VarSetCapacity(PointF,8*Points0)   
Loop,%Points0%
{
StringSplit,Coord,Points%A_Index%,`,
NumPut(Coord1,PointF,8*(A_Index-1),"float"),NumPut(Coord2,PointF,(8*(A_Index-1))+4,"float")
}
return DllCall("gdiplus\GdipDrawLines","UPtr",pGraphics,"UPtr",pPen,"UPtr",&PointF,"int",Points0)
}
Gdip_FillRectangle(pGraphics,pBrush,x,y,w,h){
return DllCall("gdiplus\GdipFillRectangle","UPtr",pGraphics,"UPtr",pBrush,"float",x,"float",y,"float",w,"float",h)
}
Gdip_FillRoundedRectangle(pGraphics,pBrush,x,y,w,h,r){
Region:=Gdip_GetClipRegion(pGraphics)
Gdip_SetClipRect(pGraphics,x-r,y-r,2*r,2*r,4)
Gdip_SetClipRect(pGraphics,x+w-r,y-r,2*r,2*r,4)
Gdip_SetClipRect(pGraphics,x-r,y+h-r,2*r,2*r,4)
Gdip_SetClipRect(pGraphics,x+w-r,y+h-r,2*r,2*r,4)
E:=Gdip_FillRectangle(pGraphics,pBrush,x,y,w,h)
Gdip_SetClipRegion(pGraphics,Region,0)
Gdip_SetClipRect(pGraphics,x-(2*r),y+r,w+(4*r),h-(2*r),4)
Gdip_SetClipRect(pGraphics,x+r,y-(2*r),w-(2*r),h+(4*r),4)
Gdip_FillEllipse(pGraphics,pBrush,x,y,2*r,2*r)
Gdip_FillEllipse(pGraphics,pBrush,x+w-(2*r),y,2*r,2*r)
Gdip_FillEllipse(pGraphics,pBrush,x,y+h-(2*r),2*r,2*r)
Gdip_FillEllipse(pGraphics,pBrush,x+w-(2*r),y+h-(2*r),2*r,2*r)
Gdip_SetClipRegion(pGraphics,Region,0)
Gdip_DeleteRegion(Region)
return E
}
Gdip_FillPolygon(pGraphics,pBrush,Points,FillMode=0){
StringSplit,Points,Points,|
VarSetCapacity(PointF,8*Points0)   
Loop,%Points0%
{
StringSplit,Coord,Points%A_Index%,`,
NumPut(Coord1,PointF,8*(A_Index-1),"float"),NumPut(Coord2,PointF,(8*(A_Index-1))+4,"float")
}   
return DllCall("gdiplus\GdipFillPolygon","UPtr",pGraphics,"UPtr",pBrush,"UPtr",&PointF,"int",Points0,"int",FillMode)
}
Gdip_FillPie(pGraphics,pBrush,x,y,w,h,StartAngle,SweepAngle){
return DllCall("gdiplus\GdipFillPie","UPtr",pGraphics,"UPtr",pBrush,"float",x,"float",y,"float",w,"float",h,"float",StartAngle,"float",SweepAngle)
}
Gdip_FillEllipse(pGraphics,pBrush,x,y,w,h){
return DllCall("gdiplus\GdipFillEllipse","UPtr",pGraphics,"UPtr",pBrush,"float",x,"float",y,"float",w,"float",h)
}
Gdip_FillRegion(pGraphics,pBrush,Region){
return DllCall("gdiplus\GdipFillRegion","UPtr",pGraphics,"UPtr",pBrush,"UPtr",Region)
}
Gdip_FillPath(pGraphics,pBrush,Path){
return DllCall("gdiplus\GdipFillPath","UPtr",pGraphics,"UPtr",pBrush,"UPtr",Path)
}
Gdip_DrawImagePointsRect(pGraphics,pBitmap,Points,sx="",sy="",sw="",sh="",Matrix=1){
StringSplit,Points,Points,|
VarSetCapacity(PointF,8*Points0)   
Loop,%Points0%
{
StringSplit,Coord,Points%A_Index%,`,
NumPut(Coord1,PointF,8*(A_Index-1),"float"),NumPut(Coord2,PointF,(8*(A_Index-1))+4,"float")
}
if(Matrix&1="")
ImageAttr:=Gdip_SetImageAttributesColorMatrix(Matrix)
else if(Matrix!=1)
ImageAttr:=Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
if(sx=""&&sy=""&&sw=""&&sh="")
{
sx:=0,sy:=0
sw:=Gdip_GetImageWidth(pBitmap)
sh:=Gdip_GetImageHeight(pBitmap)
}
E:=DllCall("gdiplus\GdipDrawImagePointsRect","UPtr",pGraphics,"UPtr",pBitmap,"UPtr",&PointF,"int",Points0,"float",sx,"float",sy,"float",sw,"float",sh,"int",2,"UPtr",ImageAttr,"UPtr",0,"UPtr",0)
if ImageAttr
Gdip_DisposeImageAttributes(ImageAttr)
return E
}
Gdip_DrawImage(pGraphics,pBitmap,dx="",dy="",dw="",dh="",sx="",sy="",sw="",sh="",Matrix=1){
if(Matrix&1="")
ImageAttr:=Gdip_SetImageAttributesColorMatrix(Matrix)
else if(Matrix!=1)
ImageAttr:=Gdip_SetImageAttributesColorMatrix("1|0|0|0|0|0|1|0|0|0|0|0|1|0|0|0|0|0|" Matrix "|0|0|0|0|0|1")
if(sx=""&&sy=""&&sw=""&&sh="")
{
if(dx=""&&dy=""&&dw=""&&dh="")
{
sx:=dx:=0,sy:=dy:=0
sw:=dw:=Gdip_GetImageWidth(pBitmap)
sh:=dh:=Gdip_GetImageHeight(pBitmap)
}
else
{
sx:=sy:=0
sw:=Gdip_GetImageWidth(pBitmap)
sh:=Gdip_GetImageHeight(pBitmap)
}
}
E:=DllCall("gdiplus\GdipDrawImageRectRect","UPtr",pGraphics,"UPtr",pBitmap,"float",dx,"float",dy,"float",dw,"float",dh,"float",sx,"float",sy,"float",sw,"float",sh,"int",2,"UPtr",ImageAttr,"UPtr",0,"UPtr",0)
if ImageAttr
Gdip_DisposeImageAttributes(ImageAttr)
return E
}
Gdip_SetImageAttributesColorMatrix(Matrix){
VarSetCapacity(ColourMatrix,100,0)
Matrix:=RegExReplace(RegExReplace(Matrix,"^[^\d-\.]+([\d\.])","$1","",1),"[^\d-\.]+","|")
StringSplit,Matrix,Matrix,|
Loop,25
{
Matrix:=(Matrix%A_Index%!="")?Matrix%A_Index%:Mod(A_Index-1,6)?0:1
NumPut(Matrix,ColourMatrix,(A_Index-1)*4,"float")
}
DllCall("gdiplus\GdipCreateImageAttributes","UPtr*",ImageAttr)
DllCall("gdiplus\GdipSetImageAttributesColorMatrix","UPtr",ImageAttr,"int",1,"int",1,"UPtr",&ColourMatrix,"UPtr",0,"int",0)
return ImageAttr
}
Gdip_GraphicsFromImage(pBitmap){
DllCall("gdiplus\GdipGetImageGraphicsContext","UPtr",pBitmap,"UPtr*",pGraphics)
return pGraphics
}
Gdip_GraphicsFromHDC(hdc){
    DllCall("gdiplus\GdipCreateFromHDC","UPtr",hdc,"UPtr*",pGraphics)
    return pGraphics
}
Gdip_GetDC(pGraphics){
DllCall("gdiplus\GdipGetDC","UPtr",pGraphics,"UPtr*",hdc)
return hdc
}
Gdip_ReleaseDC(pGraphics,hdc){
return DllCall("gdiplus\GdipReleaseDC","UPtr",pGraphics,"UPtr",hdc)
}
Gdip_GraphicsClear(pGraphics,ARGB=0x00ffffff){
    return DllCall("gdiplus\GdipGraphicsClear","UPtr",pGraphics,"int",ARGB)
}
Gdip_BlurBitmap(pBitmap,Blur){
if(Blur>100)||(Blur<1)
return -1
sWidth:=Gdip_GetImageWidth(pBitmap),sHeight:=Gdip_GetImageHeight(pBitmap)
dWidth:=sWidth//Blur,dHeight:=sHeight//Blur
pBitmap1:=Gdip_CreateBitmap(dWidth,dHeight)
G1:=Gdip_GraphicsFromImage(pBitmap1)
Gdip_SetInterpolationMode(G1,7)
Gdip_DrawImage(G1,pBitmap,0,0,dWidth,dHeight,0,0,sWidth,sHeight)
Gdip_DeleteGraphics(G1)
pBitmap2:=Gdip_CreateBitmap(sWidth,sHeight)
G2:=Gdip_GraphicsFromImage(pBitmap2)
Gdip_SetInterpolationMode(G2,7)
Gdip_DrawImage(G2,pBitmap1,0,0,sWidth,sHeight,0,0,dWidth,dHeight)
Gdip_DeleteGraphics(G2)
Gdip_DisposeImage(pBitmap1)
return pBitmap2
}
Gdip_SaveBitmapToFile(pBitmap,sOutput,Quality=75){
SplitPath,sOutput,,,Extension
if Extension not in BMP,DIB,RLE,JPG,JPEG,JPE,JFIF,GIF,TIF,TIFF,PNG
return -1
Extension:="." Extension
DllCall("gdiplus\GdipGetImageEncodersSize","uint*",nCount,"uint*",nSize)
VarSetCapacity(ci,nSize)
DllCall("gdiplus\GdipGetImageEncoders","uint",nCount,"uint",nSize,"UPtr",&ci)
if !(nCount&&nSize)
return -2
if(A_IsUnicode){
StrGet_Name:="StrGet"
Loop,%nCount%
{
sString:=%StrGet_Name%(NumGet(ci,(idx:=(48+7*A_PtrSize)*(A_Index-1))+32+3*A_PtrSize),"UTF-16")
if !InStr(sString,"*" Extension)
continue
pCodec:=&ci+idx
break
}
} else {
Loop,%nCount%
{
Location:=NumGet(ci,76*(A_Index-1)+44)
nSize:=DllCall("WideCharToMultiByte","uint",0,"uint",0,"uint",Location,"int",-1,"uint",0,"int", 0,"uint",0,"uint",0)
VarSetCapacity(sString,nSize)
DllCall("WideCharToMultiByte","uint",0,"uint",0,"uint",Location,"int",-1,"str",sString,"int",nSize,"uint",0,"uint",0)
if !InStr(sString,"*" Extension)
continue
pCodec:=&ci+76*(A_Index-1)
break
}
}
if !pCodec
return -3
if(Quality!=75)
{
Quality:=(Quality<0)?0:(Quality>100)?100:Quality
if Extension in .JPG,.JPEG,.JPE,.JFIF
{
DllCall("gdiplus\GdipGetEncoderParameterListSize","UPtr",pBitmap,"UPtr",pCodec,"uint*",nSize)
VarSetCapacity(EncoderParameters,nSize,0)
DllCall("gdiplus\GdipGetEncoderParameterList","UPtr",pBitmap,"UPtr",pCodec,"uint",nSize,"UPtr",&EncoderParameters)
Loop,% NumGet(EncoderParameters,"UInt")      
{
elem:=(24+(A_PtrSize?A_PtrSize:4))*(A_Index-1)+4+(pad:=A_PtrSize=8?4:0)
if(NumGet(EncoderParameters,elem+16,"UInt")=1)&&(NumGet(EncoderParameters,elem+20,"UInt")=6)
{
p:=elem+&EncoderParameters-pad-4
NumPut(Quality,NumGet(NumPut(4,NumPut(1,p+0)+20,"UInt")),"UInt")
break
}
}      
}
}
if(!A_IsUnicode)
{
nSize:=DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sOutput,"int",-1,"UPtr",0,"int",0)
VarSetCapacity(wOutput,nSize*2)
DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sOutput,"int",-1,"UPtr",&wOutput,"int",nSize)
VarSetCapacity(wOutput,-1)
if !VarSetCapacity(wOutput)
return -4
E:=DllCall("gdiplus\GdipSaveImageToFile","UPtr",pBitmap,"UPtr",&wOutput,"UPtr",pCodec,"uint",p?p:0)
}
else
E:=DllCall("gdiplus\GdipSaveImageToFile","UPtr",pBitmap,"UPtr",&sOutput,"UPtr",pCodec,"uint",p?p:0)
return E?-5:0
}
Gdip_GetPixel(pBitmap,x,y){
DllCall("gdiplus\GdipBitmapGetPixel","UPtr",pBitmap,"int",x,"int",y,"uint*",ARGB)
return ARGB
}
Gdip_SetPixel(pBitmap,x,y,ARGB){
return DllCall("gdiplus\GdipBitmapSetPixel","UPtr",pBitmap,"int",x,"int",y,"int",ARGB)
}
Gdip_GetImageWidth(pBitmap){
DllCall("gdiplus\GdipGetImageWidth","UPtr",pBitmap,"uint*",Width)
return Width
}
Gdip_GetImageHeight(pBitmap){
DllCall("gdiplus\GdipGetImageHeight","UPtr",pBitmap,"uint*",Height)
return Height
}
Gdip_GetImageDimensions(pBitmap,ByRef Width,ByRef Height){
DllCall("gdiplus\GdipGetImageWidth","UPtr",pBitmap,"uint*",Width)
DllCall("gdiplus\GdipGetImageHeight","UPtr",pBitmap,"uint*",Height)
}
Gdip_GetDimensions(pBitmap,ByRef Width,ByRef Height){
Gdip_GetImageDimensions(pBitmap,Width,Height)
}
Gdip_GetImagePixelFormat(pBitmap){
DllCall("gdiplus\GdipGetImagePixelFormat","UPtr",pBitmap,"UPtr*",Format)
return Format
}
Gdip_GetDpiX(pGraphics){
DllCall("gdiplus\GdipGetDpiX","UPtr",pGraphics,"float*",dpix)
return Round(dpix)
}
Gdip_GetDpiY(pGraphics){
DllCall("gdiplus\GdipGetDpiY","UPtr",pGraphics,"float*",dpiy)
return Round(dpiy)
}
Gdip_GetImageHorizontalResolution(pBitmap){
DllCall("gdiplus\GdipGetImageHorizontalResolution","UPtr",pBitmap,"float*",dpix)
return Round(dpix)
}
Gdip_GetImageVerticalResolution(pBitmap){
DllCall("gdiplus\GdipGetImageVerticalResolution","UPtr",pBitmap,"float*",dpiy)
return Round(dpiy)
}
Gdip_BitmapSetResolution(pBitmap,dpix,dpiy){
return DllCall("gdiplus\GdipBitmapSetResolution","UPtr",pBitmap,"float",dpix,"float",dpiy)
}
Gdip_CreateBitmapFromFile(sFile,IconNumber=1,IconSize=""){
SplitPath,sFile,,,ext
if ext in exe,dll
{
Sizes:=IconSize?IconSize:256 "|" 128 "|" 64 "|" 48 "|" 32 "|" 16
BufSize:=16+(2*(A_PtrSize?A_PtrSize:4))
VarSetCapacity(buf,BufSize,0)
Loop,Parse,Sizes,|
{
DllCall("PrivateExtractIcons","str",sFile,"int",IconNumber-1,"int",A_LoopField,"int",A_LoopField,"UPtr*",hIcon,"UPtr*",0,"uint",1,"uint",0)
if !hIcon
continue
if !DllCall("GetIconInfo","UPtr",hIcon,"UPtr",&buf)
{
DestroyIcon(hIcon)
continue
}
hbmMask :=NumGet(buf,12+((A_PtrSize?A_PtrSize:4)-4))
hbmColor:=NumGet(buf,12+((A_PtrSize?A_PtrSize:4)-4)+(A_PtrSize?A_PtrSize:4))
if !(hbmColor&&DllCall("GetObject","UPtr",hbmColor,"int",BufSize,"UPtr",&buf))
{
DestroyIcon(hIcon)
continue
}
break
}
if !hIcon
return -1
Width:=NumGet(buf,4,"int"),Height:=NumGet(buf,8,"int")
hbm:=CreateDIBSection(Width,-Height),hdc:=CreateCompatibleDC(),obm:=SelectObject(hdc,hbm)
if !DllCall("DrawIconEx","UPtr",hdc,"int",0,"int",0,"UPtr",hIcon,"uint",Width,"uint",Height,"uint",0,"UPtr",0,"uint",3)
{
DestroyIcon(hIcon)
return -2
}
VarSetCapacity(dib,104)
DllCall("GetObject","UPtr",hbm,"int",A_PtrSize=8?104:84,"UPtr",&dib) 
Stride:=NumGet(dib,12,"Int"),Bits:=NumGet(dib,20+(A_PtrSize=8?4:0)) 
DllCall("gdiplus\GdipCreateBitmapFromScan0","int",Width,"int",Height,"int",Stride,"int",0x26200A,"UPtr",Bits,"UPtr*",pBitmapOld)
pBitmap:=Gdip_CreateBitmap(Width,Height)
G:=Gdip_GraphicsFromImage(pBitmap),Gdip_DrawImage(G,pBitmapOld,0,0,Width,Height,0,0,Width,Height)
SelectObject(hdc,obm),DeleteObject(hbm),DeleteDC(hdc)
Gdip_DeleteGraphics(G),Gdip_DisposeImage(pBitmapOld)
DestroyIcon(hIcon)
}
else
{
if(!A_IsUnicode)
{
VarSetCapacity(wFile,1024)
DllCall("kernel32\MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sFile,"int",-1,"UPtr",&wFile,"int",512)
DllCall("gdiplus\GdipCreateBitmapFromFile","UPtr",&wFile,"UPtr*",pBitmap)
}
else
DllCall("gdiplus\GdipCreateBitmapFromFile","UPtr",&sFile,"UPtr*",pBitmap)
}
return pBitmap
}
Gdip_CreateBitmapFromHBITMAP(hBitmap,Palette=0){
DllCall("gdiplus\GdipCreateBitmapFromHBITMAP","UPtr",hBitmap,"UPtr",Palette,"UPtr*",pBitmap)
return pBitmap
}
Gdip_CreateHBITMAPFromBitmap(pBitmap,Background=0xffffffff){
DllCall("gdiplus\GdipCreateHBITMAPFromBitmap","UPtr",pBitmap,"UPtr*",hbm,"int",Background)
return hbm
}
Gdip_CreateBitmapFromHICON(hIcon){
DllCall("gdiplus\GdipCreateBitmapFromHICON","UPtr",hIcon,"UPtr*",pBitmap)
return pBitmap
}
Gdip_CreateHICONFromBitmap(pBitmap){
DllCall("gdiplus\GdipCreateHICONFromBitmap","UPtr",pBitmap,"UPtr*",hIcon)
return hIcon
}
Gdip_CreateBitmap(Width,Height,Format=0x26200A){
DllCall("gdiplus\GdipCreateBitmapFromScan0","int",Width,"int",Height,"int",0,"int",Format,"UPtr",0,"UPtr*",pBitmap)
Return pBitmap
}
Gdip_CreateBitmapFromClipboard(){
if !DllCall("OpenClipboard","UPtr",0)
return -1
if !DllCall("IsClipboardFormatAvailable","uint",8)
return -2
if !hBitmap:=DllCall("GetClipboardData","uint",2,Ptr)
return -3
if !pBitmap:=Gdip_CreateBitmapFromHBITMAP(hBitmap)
return -4
if !DllCall("CloseClipboard")
return -5
DeleteObject(hBitmap)
return pBitmap
}
Gdip_SetBitmapToClipboard(pBitmap){
off1:=A_PtrSize=8?52:44,off2:=A_PtrSize=8?32:24
hBitmap:=Gdip_CreateHBITMAPFromBitmap(pBitmap)
DllCall("GetObject","UPtr",hBitmap,"int",VarSetCapacity(oi,A_PtrSize=8?104:84,0),"UPtr",&oi)
hdib:=DllCall("GlobalAlloc","uint",2,"UPtr",40+NumGet(oi,off1,"UInt"),Ptr)
pdib:=DllCall("GlobalLock","UPtr",hdib,Ptr)
DllCall("RtlMoveMemory","UPtr",pdib,"UPtr",&oi+off2,"UPtr",40)
DllCall("RtlMoveMemory","UPtr",pdib+40,"UPtr",NumGet(oi,off2-(A_PtrSize?A_PtrSize:4),Ptr),"UPtr",NumGet(oi,off1,"UInt"))
DllCall("GlobalUnlock","UPtr",hdib)
DllCall("DeleteObject","UPtr",hBitmap)
DllCall("OpenClipboard","UPtr",0)
DllCall("EmptyClipboard")
DllCall("SetClipboardData","uint",8,"UPtr",hdib)
DllCall("CloseClipboard")
}
Gdip_CloneBitmapArea(pBitmap,x,y,w,h,Format=0x26200A){
DllCall("gdiplus\GdipCloneBitmapArea","float",x,"float",y,"float",w,"float",h,"int",Format,"UPtr",pBitmap,"UPtr*",pBitmapDest)
return pBitmapDest
}
Gdip_CreatePen(ARGB,w){
DllCall("gdiplus\GdipCreatePen1","UInt",ARGB,"float",w,"int",2,"UPtr*",pPen)
return pPen
}
Gdip_CreatePenFromBrush(pBrush,w){
DllCall("gdiplus\GdipCreatePen2","UPtr",pBrush,"float",w,"int",2,"UPtr*",pPen)
return pPen
}
Gdip_BrushCreateSolid(ARGB=0xff000000){
DllCall("gdiplus\GdipCreateSolidFill","UInt",ARGB,"UPtr*",pBrush)
return pBrush
}
Gdip_BrushCreateHatch(ARGBfront,ARGBback,HatchStyle=0){
DllCall("gdiplus\GdipCreateHatchBrush","int",HatchStyle,"UInt",ARGBfront,"UInt",ARGBback,"UPtr*",pBrush)
return pBrush
}
Gdip_CreateTextureBrush(pBitmap,WrapMode=1,x=0,y=0,w="",h=""){
if !(w&&h)
DllCall("gdiplus\GdipCreateTexture","UPtr",pBitmap,"int",WrapMode,"UPtr*",pBrush)
else
DllCall("gdiplus\GdipCreateTexture2","UPtr",pBitmap,"int",WrapMode,"float",x,"float",y,"float",w,"float",h,"UPtr*",pBrush)
return pBrush
}
Gdip_CreateLineBrush(x1,y1,x2,y2,ARGB1,ARGB2,WrapMode=1){
CreatePointF(PointF1,x1,y1),CreatePointF(PointF2,x2,y2)
DllCall("gdiplus\GdipCreateLineBrush","UPtr",&PointF1,"UPtr",&PointF2,"Uint",ARGB1,"Uint",ARGB2,"int",WrapMode,"UPtr*",LGpBrush)
return LGpBrush
}
Gdip_CreateLineBrushFromRect(x,y,w,h,ARGB1,ARGB2,LinearGradientMode=1,WrapMode=1){
CreateRectF(RectF,x,y,w,h)
DllCall("gdiplus\GdipCreateLineBrushFromRect","UPtr",&RectF,"int",ARGB1,"int",ARGB2,"int",LinearGradientMode,"int",WrapMode,"UPtr*",LGpBrush)
return LGpBrush
}
Gdip_CloneBrush(pBrush){
DllCall("gdiplus\GdipCloneBrush","UPtr",pBrush,"UPtr*",pBrushClone)
return pBrushClone
}
Gdip_DeletePen(pPen){
return DllCall("gdiplus\GdipDeletePen","UPtr",pPen)
}
Gdip_DeleteBrush(pBrush){
return DllCall("gdiplus\GdipDeleteBrush","UPtr",pBrush)
}
Gdip_DisposeImage(pBitmap){
return DllCall("gdiplus\GdipDisposeImage","UPtr",pBitmap)
}
Gdip_DeleteGraphics(pGraphics){
return DllCall("gdiplus\GdipDeleteGraphics","UPtr",pGraphics)
}
Gdip_DisposeImageAttributes(ImageAttr){
return DllCall("gdiplus\GdipDisposeImageAttributes","UPtr",ImageAttr)
}
Gdip_DeleteFont(hFont){
return DllCall("gdiplus\GdipDeleteFont","UPtr",hFont)
}
Gdip_DeleteStringFormat(hFormat){
return DllCall("gdiplus\GdipDeleteStringFormat","UPtr",hFormat)
}
Gdip_DeleteFontFamily(hFamily){
return DllCall("gdiplus\GdipDeleteFontFamily","UPtr",hFamily)
}
Gdip_DeleteMatrix(Matrix){
return DllCall("gdiplus\GdipDeleteMatrix","UPtr",Matrix)
}
Gdip_TextToGraphics(pGraphics,Text,Options,Font="Arial",Width="",Height="",Measure=0){
IWidth:=Width,IHeight:= Height
RegExMatch(Options,"i)X([\-\d\.]+)(p*)",xpos)
RegExMatch(Options,"i)Y([\-\d\.]+)(p*)",ypos)
RegExMatch(Options,"i)W([\-\d\.]+)(p*)",Width)
RegExMatch(Options,"i)H([\-\d\.]+)(p*)",Height)
RegExMatch(Options,"i)C(?!(entre|enter))([a-f\d]+)",Colour)
RegExMatch(Options,"i)Top|Up|Bottom|Down|vCentre|vCenter",vPos)
RegExMatch(Options,"i)NoWrap",NoWrap)
RegExMatch(Options,"i)R(\d)",Rendering)
RegExMatch(Options,"i)S(\d+)(p*)",Size)
if !Gdip_DeleteBrush(Gdip_CloneBrush(Colour2))
PassBrush:=1,pBrush:=Colour2
if !(IWidth&&IHeight)&&(xpos2||ypos2||Width2||Height2||Size2)
return -1
Style:=0,Styles:="Regular|Bold|Italic|BoldItalic|Underline|Strikeout"
Loop,Parse,Styles,|
{
if RegExMatch(Options,"\b" A_loopField)
Style|=(A_LoopField!="StrikeOut")?(A_Index-1):8
}
Align:=0,Alignments:="Near|Left|Centre|Center|Far|Right"
Loop,Parse,Alignments,|
{
if RegExMatch(Options,"\b" A_loopField)
Align|=A_Index//2.1
}
xpos:=(xpos1!="")?xpos2?IWidth*(xpos1/100):xpos1:0
ypos:=(ypos1!="")?ypos2?IHeight*(ypos1/100):ypos1:0
Width:=Width1?Width2?IWidth*(Width1/100):Width1:IWidth
Height:=Height1?Height2?IHeight*(Height1/100):Height1:IHeight
if !PassBrush
Colour:="0x" (Colour2?Colour2:"ff000000")
Rendering:=((Rendering1>=0)&&(Rendering1<=5))?Rendering1:4
Size:=(Size1>0)?Size2?IHeight*(Size1/100):Size1:12
hFamily:=Gdip_FontFamilyCreate(Font)
hFont:=Gdip_FontCreate(hFamily,Size,Style)
FormatStyle:=NoWrap?0x4000|0x1000:0x4000
hFormat:=Gdip_StringFormatCreate(FormatStyle)
pBrush:=PassBrush?pBrush:Gdip_BrushCreateSolid(Colour)
if !(hFamily&&hFont&&hFormat&&pBrush&&pGraphics)
return !pGraphics?-2:!hFamily?-3:!hFont?-4:!hFormat?-5:!pBrush?-6:0
CreateRectF(RC,xpos,ypos,Width,Height)
Gdip_SetStringFormatAlign(hFormat,Align)
Gdip_SetTextRenderingHint(pGraphics,Rendering)
ReturnRC:=Gdip_MeasureString(pGraphics,Text,hFont,hFormat,RC)
if vPos
{
StringSplit,ReturnRC,ReturnRC,|
if(vPos="vCentre")||(vPos="vCenter")
ypos+=(Height-ReturnRC4)//2
else if(vPos="Top")||(vPos="Up")
ypos:=0
else if(vPos="Bottom")||(vPos="Down")
ypos:=Height-ReturnRC4
CreateRectF(RC,xpos,ypos,Width,ReturnRC4)
ReturnRC:=Gdip_MeasureString(pGraphics,Text,hFont,hFormat,RC)
}
if !Measure
E:=Gdip_DrawString(pGraphics,Text,hFont,hFormat,pBrush,RC)
if !PassBrush
Gdip_DeleteBrush(pBrush)
Gdip_DeleteStringFormat(hFormat)   
Gdip_DeleteFont(hFont)
Gdip_DeleteFontFamily(hFamily)
return E?E:ReturnRC
}
Gdip_DrawString(pGraphics,sString,hFont,hFormat,pBrush,ByRef RectF){
if(!A_IsUnicode)
{
nSize:=DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sString,"int",-1,"UPtr",0,"int",0)
VarSetCapacity(wString,nSize*2)
DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sString,"int",-1,"UPtr",&wString,"int",nSize)
}
return DllCall("gdiplus\GdipDrawString","UPtr",pGraphics,"UPtr",A_IsUnicode?&sString:&wString,"int",-1,"UPtr",hFont,"UPtr",&RectF,"UPtr",hFormat,"UPtr",pBrush)
}
Gdip_MeasureString(pGraphics,sString,hFont,hFormat,ByRef RectF){
VarSetCapacity(RC,16)
if !A_IsUnicode
{
nSize:=DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sString,"int",-1,"uint",0,"int",0)
VarSetCapacity(wString,nSize*2)   
DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&sString,"int",-1,"UPtr",&wString,"int",nSize)
}
DllCall("gdiplus\GdipMeasureString","UPtr",pGraphics,"UPtr",A_IsUnicode?&sString:&wString,"int",-1,"UPtr",hFont,"UPtr",&RectF,"UPtr",hFormat,"UPtr",&RC,"uint*",Chars,"uint*",Lines)
return &RC?NumGet(RC,0,"float") "|" NumGet(RC,4,"float") "|" NumGet(RC,8,"float") "|" NumGet(RC,12,"float") "|" Chars "|" Lines:0
}
Gdip_SetStringFormatAlign(hFormat,Align){
return DllCall("gdiplus\GdipSetStringFormatAlign","UPtr",hFormat,"int",Align)
}
Gdip_StringFormatCreate(Format=0,Lang=0){
DllCall("gdiplus\GdipCreateStringFormat","int",Format,"int",Lang,"UPtr*",hFormat)
return hFormat
}
Gdip_FontCreate(hFamily,Size,Style=0){
DllCall("gdiplus\GdipCreateFont","UPtr",hFamily,"float",Size,"int",Style,"int",0,"UPtr*",hFont)
return hFont
}
Gdip_FontFamilyCreate(Font){
if(!A_IsUnicode)
{
nSize:=DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&Font,"int",-1,"uint",0,"int",0)
VarSetCapacity(wFont,nSize*2)
DllCall("MultiByteToWideChar","uint",0,"uint",0,"UPtr",&Font,"int",-1,"UPtr",&wFont,"int",nSize)
}
DllCall("gdiplus\GdipCreateFontFamilyFromName","UPtr",A_IsUnicode?&Font:&wFont,"uint",0,"UPtr*",hFamily)
return hFamily
}
Gdip_CreateAffineMatrix(m11,m12,m21,m22,x,y){
DllCall("gdiplus\GdipCreateMatrix2","float",m11,"float",m12,"float",m21,"float",m22,"float",x,"float",y,"UPtr*",Matrix)
return Matrix
}
Gdip_CreateMatrix(){
DllCall("gdiplus\GdipCreateMatrix","UPtr*",Matrix)
return Matrix
}
Gdip_CreatePath(BrushMode=0){
DllCall("gdiplus\GdipCreatePath","int",BrushMode,"UPtr*",Path)
return Path
}
Gdip_AddPathEllipse(Path,x,y,w,h){
return DllCall("gdiplus\GdipAddPathEllipse","UPtr",Path,"float",x,"float",y,"float",w,"float",h)
}
Gdip_AddPathPolygon(Path,Points){
StringSplit,Points,Points,|
VarSetCapacity(PointF,8*Points0)   
Loop,%Points0%
{
StringSplit,Coord,Points%A_Index%,`,
NumPut(Coord1,PointF,8*(A_Index-1),"float"),NumPut(Coord2,PointF,(8*(A_Index-1))+4,"float")
}   
return DllCall("gdiplus\GdipAddPathPolygon","UPtr",Path,"UPtr",&PointF,"int",Points0)
}
Gdip_DeletePath(Path){
return DllCall("gdiplus\GdipDeletePath","UPtr",Path)
}
Gdip_SetTextRenderingHint(pGraphics,RenderingHint){
return DllCall("gdiplus\GdipSetTextRenderingHint","UPtr",pGraphics,"int",RenderingHint)
}
Gdip_SetInterpolationMode(pGraphics,InterpolationMode){
return DllCall("gdiplus\GdipSetInterpolationMode","UPtr",pGraphics,"int",InterpolationMode)
}
Gdip_SetSmoothingMode(pGraphics,SmoothingMode){
return DllCall("gdiplus\GdipSetSmoothingMode","UPtr",pGraphics,"int",SmoothingMode)
}
Gdip_SetCompositingMode(pGraphics,CompositingMode=0){
return DllCall("gdiplus\GdipSetCompositingMode","UPtr",pGraphics,"int",CompositingMode)
}
Gdip_Startup(){
if !DllCall("GetModuleHandle","str","gdiplus",Ptr)
DllCall("LoadLibrary","str","gdiplus")
VarSetCapacity(si,A_PtrSize=8?24:16,0),si:=Chr(1)
DllCall("gdiplus\GdiplusStartup","UPtr*",pToken,"UPtr",&si,"UPtr",0)
return pToken
}
Gdip_Shutdown(pToken){
DllCall("gdiplus\GdiplusShutdown","UPtr",pToken)
if hModule:=DllCall("GetModuleHandle","str","gdiplus",Ptr)
DllCall("FreeLibrary","UPtr",hModule)
return 0
}
Gdip_RotateWorldTransform(pGraphics,Angle,MatrixOrder=0){
return DllCall("gdiplus\GdipRotateWorldTransform","UPtr",pGraphics,"float",Angle,"int",MatrixOrder)
}
Gdip_ScaleWorldTransform(pGraphics,x,y,MatrixOrder=0){
return DllCall("gdiplus\GdipScaleWorldTransform","UPtr",pGraphics,"float",x,"float",y,"int",MatrixOrder)
}
Gdip_TranslateWorldTransform(pGraphics,x,y,MatrixOrder=0){
return DllCall("gdiplus\GdipTranslateWorldTransform","UPtr",pGraphics,"float",x,"float",y,"int",MatrixOrder)
}
Gdip_ResetWorldTransform(pGraphics){
return DllCall("gdiplus\GdipResetWorldTransform","UPtr",pGraphics)
}
Gdip_GetRotatedTranslation(Width,Height,Angle,ByRef xTranslation,ByRef yTranslation){
pi:=3.14159,TAngle:=Angle*(pi/180)
Bound:=(Angle>=0)?Mod(Angle,360):360-Mod(-Angle,-360)
if((Bound>=0)&&(Bound<=90))
xTranslation:=Height*Sin(TAngle),yTranslation:=0
else if((Bound>90)&&(Bound<=180))
xTranslation:=(Height*Sin(TAngle))-(Width*Cos(TAngle)),yTranslation:=-Height*Cos(TAngle)
else if((Bound>180)&&(Bound<=270))
xTranslation:=-(Width*Cos(TAngle)),yTranslation:=-(Height*Cos(TAngle))-(Width*Sin(TAngle))
else if((Bound>270)&&(Bound<=360))
xTranslation:=0,yTranslation:=-Width*Sin(TAngle)
}
Gdip_GetRotatedDimensions(Width,Height,Angle,ByRef RWidth,ByRef RHeight){
pi:=3.14159,TAngle:=Angle*(pi/180)
if !(Width&&Height)
return -1
RWidth:=Ceil(Abs(Width*Cos(TAngle))+Abs(Height*Sin(TAngle)))
RHeight:=Ceil(Abs(Width*Sin(TAngle))+Abs(Height*Cos(Tangle)))
}
Gdip_ImageRotateFlip(pBitmap,RotateFlipType=1){
return DllCall("gdiplus\GdipImageRotateFlip","UPtr",pBitmap,"int",RotateFlipType)
}
Gdip_SetClipRect(pGraphics,x,y,w,h,CombineMode=0){
return DllCall("gdiplus\GdipSetClipRect", "UPtr",pGraphics,"float",x,"float",y,"float",w,"float",h,"int",CombineMode)
}
Gdip_SetClipPath(pGraphics,Path,CombineMode=0){
return DllCall("gdiplus\GdipSetClipPath","UPtr",pGraphics,"UPtr",Path,"int",CombineMode)
}
Gdip_ResetClip(pGraphics){
return DllCall("gdiplus\GdipResetClip","UPtr",pGraphics)
}
Gdip_GetClipRegion(pGraphics){
Region:=Gdip_CreateRegion()
DllCall("gdiplus\GdipGetClip","UPtr",pGraphics,"UInt*",Region)
return Region
}
Gdip_SetClipRegion(pGraphics,Region,CombineMode=0){
return DllCall("gdiplus\GdipSetClipRegion","UPtr",pGraphics,"UPtr",Region,"int",CombineMode)
}
Gdip_CreateRegion(){
DllCall("gdiplus\GdipCreateRegion","UInt*",Region)
return Region
}
Gdip_DeleteRegion(Region){
return DllCall("gdiplus\GdipDeleteRegion","UPtr",Region)
}
Gdip_LockBits(pBitmap,x,y,w,h,ByRef Stride,ByRef Scan0,ByRef BitmapData,LockMode=3,PixelFormat=0x26200a){
CreateRect(Rect,x,y,w,h)
VarSetCapacity(BitmapData,16+2*(A_PtrSize?A_PtrSize:4),0)
E:=DllCall("Gdiplus\GdipBitmapLockBits","UPtr",pBitmap,"UPtr",&Rect,"uint",LockMode,"int",PixelFormat,"UPtr",&BitmapData)
Stride:=NumGet(BitmapData,8,"Int")
Scan0:=NumGet(BitmapData,16,Ptr)
return E
}
Gdip_UnlockBits(pBitmap,ByRef BitmapData){
return DllCall("Gdiplus\GdipBitmapUnlockBits","UPtr",pBitmap,"UPtr",&BitmapData)
}
Gdip_SetLockBitPixel(ARGB,Scan0,x,y,Stride){
Numput(ARGB,Scan0+0,(x*4)+(y*Stride),"UInt")
}
Gdip_GetLockBitPixel(Scan0,x,y,Stride){
return NumGet(Scan0+0,(x*4)+(y*Stride),"UInt")
}
Gdip_PixelateBitmap(pBitmap,ByRef pBitmapOut,BlockSize){
static PixelateBitmap
if(!PixelateBitmap)
{
if A_PtrSize!=8 
MCode_PixelateBitmap=
(LTrim Join
558BEC83EC3C8B4514538B5D1C99F7FB56578BC88955EC894DD885C90F8E830200008B451099F7FB8365DC008365E000894DC88955F08945E833FF897DD4
397DE80F8E160100008BCB0FAFCB894DCC33C08945F88945FC89451C8945143BD87E608B45088D50028BC82BCA8BF02BF2418945F48B45E02955F4894DC4
8D0CB80FAFCB03CA895DD08BD1895DE40FB64416030145140FB60201451C8B45C40FB604100145FC8B45F40FB604020145F883C204FF4DE475D6034D18FF
4DD075C98B4DCC8B451499F7F98945148B451C99F7F989451C8B45FC99F7F98945FC8B45F899F7F98945F885DB7E648B450C8D50028BC82BCA83C103894D
C48BC82BCA41894DF48B4DD48945E48B45E02955E48D0C880FAFCB03CA895DD08BD18BF38A45148B7DC48804178A451C8B7DF488028A45FC8804178A45F8
8B7DE488043A83C2044E75DA034D18FF4DD075CE8B4DCC8B7DD447897DD43B7DE80F8CF2FEFFFF837DF0000F842C01000033C08945F88945FC89451C8945
148945E43BD87E65837DF0007E578B4DDC034DE48B75E80FAF4D180FAFF38B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945CC0F
B6440E030145140FB60101451C0FB6440F010145FC8B45F40FB604010145F883C104FF4DCC75D8FF45E4395DE47C9B8B4DF00FAFCB85C9740B8B451499F7
F9894514EB048365140033F63BCE740B8B451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB
038975F88975E43BDE7E5A837DF0007E4C8B4DDC034DE48B75E80FAF4D180FAFF38B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955CC8A55
1488540E038A551C88118A55FC88540F018A55F888140183C104FF4DCC75DFFF45E4395DE47CA68B45180145E0015DDCFF4DC80F8594FDFFFF8B451099F7
FB8955F08945E885C00F8E450100008B45EC0FAFC38365DC008945D48B45E88945CC33C08945F88945FC89451C8945148945103945EC7E6085DB7E518B4D
D88B45080FAFCB034D108D50020FAF4D18034DDC8BF08BF88945F403CA2BF22BFA2955F4895DC80FB6440E030145140FB60101451C0FB6440F010145FC8B
45F40FB604080145F883C104FF4DC875D8FF45108B45103B45EC7CA08B4DD485C9740B8B451499F7F9894514EB048365140033F63BCE740B8B451C99F7F9
89451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975103975EC7E5585DB7E468B4DD88B450C
0FAFCB034D108D50020FAF4D18034DDC8BF08BF803CA2BF22BFA2BC2895DC88A551488540E038A551C88118A55FC88540F018A55F888140183C104FF4DC8
75DFFF45108B45103B45EC7CAB8BC3C1E0020145DCFF4DCC0F85CEFEFFFF8B4DEC33C08945F88945FC89451C8945148945103BC87E6C3945F07E5C8B4DD8
8B75E80FAFCB034D100FAFF30FAF4D188B45088D500203CA8D0CB18BF08BF88945F48B45F02BF22BFA2955F48945C80FB6440E030145140FB60101451C0F
B6440F010145FC8B45F40FB604010145F883C104FF4DC875D833C0FF45108B4DEC394D107C940FAF4DF03BC874068B451499F7F933F68945143BCE740B8B
451C99F7F989451CEB0389751C3BCE740B8B45FC99F7F98945FCEB038975FC3BCE740B8B45F899F7F98945F8EB038975F88975083975EC7E63EB0233F639
75F07E4F8B4DD88B75E80FAFCB034D080FAFF30FAF4D188B450C8D500203CA8D0CB18BF08BF82BF22BFA2BC28B55F08955108A551488540E038A551C8811
8A55FC88540F018A55F888140883C104FF4D1075DFFF45088B45083B45EC7C9F5F5E33C05BC9C21800
)
else 
MCode_PixelateBitmap=
(LTrim Join
4489442418488954241048894C24085355565741544155415641574883EC28418BC1448B8C24980000004C8BDA99488BD941F7F9448BD0448BFA8954240C
448994248800000085C00F8E9D020000418BC04533E4458BF299448924244C8954241041F7F933C9898C24980000008BEA89542404448BE889442408EB05
4C8B5C24784585ED0F8E1A010000458BF1418BFD48897C2418450FAFF14533D233F633ED4533E44533ED4585C97E5B4C63BC2490000000418D040A410FAF
C148984C8D441802498BD9498BD04D8BD90FB642010FB64AFF4403E80FB60203E90FB64AFE4883C2044403E003F149FFCB75DE4D03C748FFCB75D0488B7C
24188B8C24980000004C8B5C2478418BC59941F7FE448BE8418BC49941F7FE448BE08BC59941F7FE8BE88BC69941F7FE8BF04585C97E4048639C24900000
004103CA4D8BC1410FAFC94863C94A8D541902488BCA498BC144886901448821408869FF408871FE4883C10448FFC875E84803D349FFC875DA8B8C249800
0000488B5C24704C8B5C24784183C20448FFCF48897C24180F850AFFFFFF8B6C2404448B2424448B6C24084C8B74241085ED0F840A01000033FF33DB4533
DB4533D24533C04585C97E53488B74247085ED7E42438D0C04418BC50FAF8C2490000000410FAFC18D04814863C8488D5431028BCD0FB642014403D00FB6
024883C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC17CB28BCD410FAFC985C9740A418BC299F7F98BF0EB0233F685C9740B418BC3
99F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585C97E4D4C8B74247885ED7E3841
8D0C14418BC50FAF8C2490000000410FAFC18D04814863C84A8D4431028BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2413BD17CBD
4C8B7424108B8C2498000000038C2490000000488B5C24704503E149FFCE44892424898C24980000004C897424100F859EFDFFFF448B7C240C448B842480
000000418BC09941F7F98BE8448BEA89942498000000896C240C85C00F8E3B010000448BAC2488000000418BCF448BF5410FAFC9898C248000000033FF33
ED33F64533DB4533D24533C04585FF7E524585C97E40418BC5410FAFC14103C00FAF84249000000003C74898488D541802498BD90FB642014403D00FB602
4883C2044403D80FB642FB03F00FB642FA03E848FFCB75DE488B5C247041FFC0453BC77CAE85C9740B418BC299F7F9448BE0EB034533E485C9740A418BC3
99F7F98BD8EB0233DB85C9740A8BC699F7F9448BD8EB034533DB85C9740A8BC599F7F9448BD0EB034533D24533C04585FF7E4E488B4C24784585C97E3541
8BC5410FAFC14103C00FAF84249000000003C74898488D540802498BC144886201881A44885AFF448852FE4883C20448FFC875E941FFC0453BC77CBE8B8C
2480000000488B5C2470418BC1C1E00203F849FFCE0F85ECFEFFFF448BAC24980000008B6C240C448BA4248800000033FF33DB4533DB4533D24533C04585
FF7E5A488B7424704585ED7E48418BCC8BC5410FAFC94103C80FAF8C2490000000410FAFC18D04814863C8488D543102418BCD0FB642014403D00FB60248
83C2044403D80FB642FB03D80FB642FA03F848FFC975DE41FFC0453BC77CAB418BCF410FAFCD85C9740A418BC299F7F98BF0EB0233F685C9740B418BC399
F7F9448BD8EB034533DB85C9740A8BC399F7F9448BD0EB034533D285C9740A8BC799F7F9448BC0EB034533C033D24585FF7E4E4585ED7E42418BCC8BC541
0FAFC903CA0FAF8C2490000000410FAFC18D04814863C8488B442478488D440102418BCD40887001448818448850FF448840FE4883C00448FFC975E8FFC2
413BD77CB233C04883C428415F415E415D415C5F5E5D5BC3
)
VarSetCapacity(PixelateBitmap,StrLen(MCode_PixelateBitmap)//2)
Loop % StrLen(MCode_PixelateBitmap)//2
NumPut("0x" SubStr(MCode_PixelateBitmap,(2*A_Index)-1,2),PixelateBitmap,A_Index-1,"UChar")
DllCall("VirtualProtect","UPtr",&PixelateBitmap,"UPtr",VarSetCapacity(PixelateBitmap),"uint",0x40,"UPtr*",0)
}
Gdip_GetImageDimensions(pBitmap,Width,Height)
if(Width!=Gdip_GetImageWidth(pBitmapOut)||Height!=Gdip_GetImageHeight(pBitmapOut))
return -1
if(BlockSize>Width||BlockSize>Height)
return -2
E1:=Gdip_LockBits(pBitmap,0,0,Width,Height,Stride1,Scan01,BitmapData1)
E2:=Gdip_LockBits(pBitmapOut,0,0,Width,Height,Stride2,Scan02,BitmapData2)
if(E1||E2)
return -3
E:=DllCall(&PixelateBitmap,"UPtr",Scan01,"UPtr",Scan02,"int",Width,"int",Height,"int",Stride1,"int",BlockSize)
Gdip_UnlockBits(pBitmap,BitmapData1),Gdip_UnlockBits(pBitmapOut,BitmapData2)
return 0
}
Gdip_ToARGB(A,R,G,B){
return (A<<24)|(R<<16)|(G<<8)|B
}
Gdip_FromARGB(ARGB,ByRef A,ByRef R,ByRef G,ByRef B){
A:=(0xff000000&ARGB)>>24
R:=(0x00ff0000&ARGB)>>16
G:=(0x0000ff00&ARGB)>>8
B:=0x000000ff&ARGB
}
Gdip_AFromARGB(ARGB){
return (0xff000000&ARGB)>>24
}
Gdip_RFromARGB(ARGB){
return (0x00ff0000&ARGB)>>16
}
Gdip_GFromARGB(ARGB){
return (0x0000ff00&ARGB)>>8
}
Gdip_BFromARGB(ARGB){
return 0x000000ff&ARGB
}
StrGetB(Address,Length=-1,Encoding=0){
if Length is not integer
Encoding:=Length,Length:=-1
if(Address+0<1024)
return
if Encoding=UTF-16
Encoding=1200
else if Encoding=UTF-8
Encoding=65001
else if SubStr(Encoding,1,2)="CP"
Encoding:=SubStr(Encoding,3)
if !Encoding
{
if(Length==-1)
Length:=DllCall("lstrlen","uint",Address)
VarSetCapacity(String,Length)
DllCall("lstrcpyn","str",String,"uint",Address,"int",Length+1)
}
else if Encoding=1200 
{
char_count:=DllCall("WideCharToMultiByte","uint",0,"uint",0x400,"uint",Address,"int",Length,"uint",0,"uint",0,"uint",0,"uint",0)
VarSetCapacity(String,char_count)
DllCall("WideCharToMultiByte","uint",0,"uint",0x400,"uint",Address,"int",Length,"str",String,"int",char_count,"uint",0,"uint",0)
}
else if Encoding is integer
{
char_count:=DllCall("MultiByteToWideChar","uint",Encoding,"uint",0,"uint",Address,"int",Length,"uint",0,"int",0)
VarSetCapacity(String,char_count*2)
char_count:=DllCall("MultiByteToWideChar","uint",Encoding,"uint",0,"uint",Address,"int",Length,"uint",&String,"int",char_count*2)
String:=StrGetB(&String,char_count,1200)
}
return String
}
Gdip_ImageSearch(pBitmapHaystack,pBitmapNeedle,ByRef OutputList="",OuterX1=0,OuterY1=0,OuterX2=0,OuterY2=0,Variation=0,Trans="",SearchDirection=1,Instances=1,LineDelim="`n",CoordDelim=","){
If !(pBitmapHaystack&&pBitmapNeedle)
Return -1001
If Variation not between 0 and 255
return -1002
if((OuterX1<0 )||( OuterY1<0 ))
return -1003
If SearchDirection not between 1 and 8
    SearchDirection:=1
if( Instances<0 )
    Instances:=0
Gdip_GetImageDimensions(pBitmapHaystack,hWidth,hHeight)
If Gdip_LockBits(pBitmapHaystack,0,0,hWidth,hHeight,hStride,hScan,hBitmapData,1)
OR !(hWidth:=NumGet(hBitmapData,0))
OR !(hHeight:=NumGet(hBitmapData,4))
    Return -1004
Gdip_GetImageDimensions(pBitmapNeedle,nWidth,nHeight)
If Trans between 0 and 0xFFFFFF
{
pOriginalBmpNeedle:=pBitmapNeedle
pBitmapNeedle:=Gdip_CloneBitmapArea(pOriginalBmpNeedle,0,0,nWidth,nHeight)
Gdip_SetBitmapTransColor(pBitmapNeedle,Trans)
DumpCurrentNeedle:=true
}
If Gdip_LockBits(pBitmapNeedle,0,0,nWidth,nHeight,nStride,nScan,nBitmapData)
OR !(nWidth:=NumGet(nBitmapData,0))
OR !(nHeight:=NumGet(nBitmapData,4))
{
if(DumpCurrentNeedle)
Gdip_DisposeImage(pBitmapNeedle)
Gdip_UnlockBits(pBitmapHaystack,hBitmapData)
Return -1005
}
OuterX2:=(!OuterX2?hWidth-nWidth+1:OuterX2-nWidth+1)
OuterY2:=(!OuterY2?hHeight-nHeight+1:OuterY2-nHeight+1)
OutputCount:=Gdip_MultiLockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight,OutputList,OuterX1,OuterY1,OuterX2,OuterY2,Variation,SearchDirection,Instances,LineDelim,CoordDelim)
Gdip_UnlockBits(pBitmapHaystack,hBitmapData)
Gdip_UnlockBits(pBitmapNeedle,nBitmapData)
if(DumpCurrentNeedle)
Gdip_DisposeImage(pBitmapNeedle)
Return OutputCount
}
Gdip_SetBitmapTransColor(pBitmap,TransColor){
static _SetBmpTrans
if !( _SetBmpTrans){
MCode_SetBmpTrans:="
(LTrim Join
8b44240c558b6c241cc745000000000085c07e77538b5c2410568b74242033c9578b7c2414894c24288da424000000
0085db7e458bc18d1439b9020000008bff8a0c113a4e0275178a4c38013a4e01750e8a0a3a0e7508c644380300ff450083c0
0483c204b9020000004b75d38b4c24288b44241c8b5c2418034c242048894c24288944241c75a85f5e5b33c05dc3,405
34c8b5424388bda41c702000000004585c07e6448897c2410458bd84c8b4424304963f94c8d49010f1f800000000085db7e3
8498bc1488bd3660f1f440000410fb648023848017519410fb6480138087510410fb6083848ff7507c640020041ff024883c
00448ffca75d44c03cf49ffcb75bc488b7c241033c05bc3
)"
if(A_PtrSize==8)
MCode_SetBmpTrans:=SubStr(MCode_SetBmpTrans,InStr(MCode_SetBmpTrans,",")+1)
else
MCode_SetBmpTrans:=SubStr(MCode_SetBmpTrans,1,InStr(MCode_SetBmpTrans,",")-1)
VarSetCapacity(_SetBmpTrans,LEN:=StrLen(MCode_SetBmpTrans)//2,0)
Loop,%LEN%
NumPut("0x" . SubStr(MCode_SetBmpTrans,(2*A_Index)-1,2),_SetBmpTrans,A_Index-1,"uchar")
MCode_SetBmpTrans:=""
DllCall("VirtualProtect","UPtr",&_SetBmpTrans,"UPtr",VarSetCapacity(_SetBmpTrans),"uint",0x40,"UPtr*",0)
}
If !pBitmap
Return -2001
If TransColor not between 0 and 0xFFFFFF
Return -2002
Gdip_GetImageDimensions(pBitmap,W,H)
If !(W&&H)
Return -2003
If Gdip_LockBits(pBitmap,0,0,W,H,Stride,Scan,BitmapData)
Return -2004
Gdip_FromARGB(TransColor,A,R,G,B),VarSetCapacity(TransColor,0),VarSetCapacity(TransColor,3,255)
NumPut(B,TransColor,0,"UChar"),NumPut(G,TransColor,1,"UChar"),NumPut(R,TransColor,2,"UChar")
MCount:=0
E:=DllCall(&_SetBmpTrans,"UPtr",Scan,"int",W,"int",H,"int",Stride,"UPtr",&TransColor,"int*",MCount,"cdecl int")
Gdip_UnlockBits(pBitmap,BitmapData)
if(E!=0){
ErrorLevel:=E
Return -2005
}
Return MCount
}
Gdip_MultiLockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight,ByRef OutputList="",OuterX1=0,OuterY1=0,OuterX2=0,OuterY2=0,Variation=0,SearchDirection=1,Instances=0,LineDelim="`n",CoordDelim=","){
OutputList:=""
OutputCount:=!Instances
InnerX1:=OuterX1 ,InnerY1:=OuterY1
InnerX2:=OuterX2 ,InnerY2:=OuterY2
iX:=1,stepX:=1,iY:=1,stepY:=1
Modulo:=Mod(SearchDirection,4)
if(Modulo>1)
iY:=2,stepY:=0
If !Mod(Modulo,3)
iX:=2,stepX:=0
P:="Y",N:="X"
if(SearchDirection>4)
P:="X",N:="Y"
iP:=i%P%,iN:=i%N%
While(!(OutputCount==Instances)&&(0==Gdip_LockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight,FoundX,FoundY,OuterX1,OuterY1,OuterX2,OuterY2,Variation,SearchDirection))){
OutputCount++
OutputList.=LineDelim FoundX CoordDelim FoundY
Outer%P%%iP%:=Found%P%+step%P%
Inner%N%%iN%:=Found%N%+step%N%
Inner%P%1:=Found%P%
Inner%P%2:=Found%P%+1
While(!(OutputCount==Instances)&&(0==Gdip_LockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight,FoundX,FoundY,InnerX1,InnerY1,InnerX2,InnerY2,Variation,SearchDirection))){
OutputCount++
OutputList.=LineDelim FoundX CoordDelim FoundY
Inner%N%%iN%:=Found%N%+step%N%
}
}
OutputList:=SubStr(OutputList,1+StrLen(LineDelim))
OutputCount-=!Instances
Return OutputCount
}
Gdip_LockedBitsSearch(hStride,hScan,hWidth,hHeight,nStride,nScan,nWidth,nHeight,ByRef x="",ByRef y="",sx1=0,sy1=0,sx2=0,sy2=0,Variation=0,sd=1){
static _ImageSearch
if !(_ImageSearch){
MCode_ImageSearch:="
(LTrim Join
8b44243883ec205355565783f8010f857a0100008b7c2458897c24143b7c24600f8db50b00008b44244c8b5c245c8b
4c24448b7424548be80fafef896c242490897424683bf30f8d0a0100008d64240033c033db8bf5896c241c895c2420894424
183b4424480f8d0401000033c08944241085c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b80300
0000803c18008b442410745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b44
24400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424108b7c
24408b4c24444083c50483c30483c604894424103bc17c818b5c24208b74241c0374244c8b44241840035c24508974241ce9
2dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24240f8c06ffffff8b44244c8b7c24148b7424544703e8897c
2414896c24243b7c24600f8cd5feffffe96b0a00008b4424348b4c246889088b4424388b4c24145f5e5d890833c05b83c420
c383f8020f85870100008b7c24604f897c24103b7c24580f8c310a00008b44244c8b5c245c8b4c24448bef0fafe8f7d88944
24188b4424548b742418896c24288d4900894424683bc30f8d0a0100008d64240033c033db8bf5896c2420895c241c894424
243b4424480f8d0401000033c08944241485c90f8e9d0000008b5424688b7c24408beb8d34968b54246403df8d4900b80300
0000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b44
24400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c
24408b4c24444083c50483c30483c604894424143bc17c818b5c241c8b7424200374244c8b44242440035c245089742420e9
2dffffff8b6c24688b5c245c8b4c244445896c24683beb8b6c24280f8c06ffffff8b7c24108b4424548b7424184f03ee897c
2410896c24283b7c24580f8dd5feffffe9db0800008b4424348b4c246889088b4424388b4c24105f5e5d890833c05b83c420
c383f8030f85650100008b7c24604f897c24103b7c24580f8ca10800008b44244c8b6c245c8b5c24548b4c24448bf70faff0
4df7d8896c242c897424188944241c8bff896c24683beb0f8c020100008d64240033c033db89742424895c2420894424283b
4424480f8d76ffffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b80300
0000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b44
24400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c
24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff
8b6c24688b5c24548b4c24448b7424184d896c24683beb0f8d0affffff8b7c24108b44241c4f03f0897c2410897424183b7c
24580f8c580700008b6c242ce9d4feffff83f8040f85670100008b7c2458897c24103b7c24600f8d340700008b44244c8b6c
245c8b5c24548b4c24444d8bf00faff7896c242c8974241ceb098da424000000008bff896c24683beb0f8c020100008d6424
0033c033db89742424895c2420894424283b4424480f8d06feffff33c08944241485c90f8e9f0000008b5424688b7c24408b
eb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f
752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d
04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b742424
8b4424280374244c40035c2450e92bffffff8b6c24688b5c24548b4c24448b74241c4d896c24683beb0f8d0affffff8b4424
4c8b7c24104703f0897c24108974241c3b7c24600f8de80500008b6c242ce9d4feffff83f8050f85890100008b7c2454897c
24683b7c245c0f8dc40500008b5c24608b6c24588b44244c8b4c2444eb078da42400000000896c24103beb0f8d200100008b
e80faf6c2458896c241c33c033db8bf5896c2424895c2420894424283b4424480f8d0d01000033c08944241485c90f8ea600
00008b5424688b7c24408beb8d34968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44
243c0fb67c2f020fb64c06028d04113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a
2bca3bf97c548b44243c0fb63b0fb60c068d04113bf87f422bca3bf97c3c8b4424148b7c24408b4c24444083c50483c30483
c604894424143bc17c818b5c24208b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44
244c8b5c24608b4c24444703e8897c2410896c241c3bfb0f8cf3feffff8b7c24688b6c245847897c24683b7c245c0f8cc5fe
ffffe96b0400008b4424348b4c24688b74241089088b4424385f89305e5d33c05b83c420c383f8060f85670100008b7c2454
897c24683b7c245c0f8d320400008b6c24608b5c24588b44244c8b4c24444d896c24188bff896c24103beb0f8c1a0100008b
f50faff0f7d88974241c8944242ceb038d490033c033db89742424895c2420894424283b4424480f8d06fbffff33c0894424
1485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d4900b803000000803c03008b442414745e8b44
243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c06018b4424400fb67c28018d04113bf87f56
2bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b4424148b7c24408b4c24444083c50483c30483
c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e92bffffff8b6c24108b74241c0374242c8b5c
24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c246847897c24683b7c245c0f8de60200008b6c2418
e9c2feffff83f8070f85670100008b7c245c4f897c24683b7c24540f8cc10200008b6c24608b5c24588b44244c8b4c24444d
896c241890896c24103beb0f8c1a0100008bf50faff0f7d88974241c8944242ceb038d490033c033db89742424895c242089
4424283b4424480f8d96f9ffff33c08944241485c90f8e9f0000008b5424688b7c24408beb8d34968b54246403dfeb038d49
00b803000000803c18008b442414745e8b44243c0fb67c2f020fb64c06028d04113bf87f752bca3bf97c6f8b44243c0fb64c
06018b4424400fb67c28018d04113bf87f562bca3bf97c508b44243c0fb63b0fb60c068d04113bf87f3e2bca3bf97c388b44
24148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c24208b7424248b4424280374244c40035c2450e9
2bffffff8b6c24108b74241c0374242c8b5c24588b4c24444d896c24108974241c3beb0f8d02ffffff8b44244c8b7c24684f
897c24683b7c24540f8c760100008b6c2418e9c2feffff83f8080f85640100008b7c245c4f897c24683b7c24540f8c510100
008b5c24608b6c24588b44244c8b4c24448d9b00000000896c24103beb0f8d200100008be80faf6c2458896c241c33c033db
8bf5896c2424895c2420894424283b4424480f8d9dfcffff33c08944241485c90f8ea60000008b5424688b7c24408beb8d34
968b54246403dfeb0a8da424000000008d4900b803000000803c03008b442414745e8b44243c0fb67c2f020fb64c06028d04
113bf87f792bca3bf97c738b44243c0fb64c06018b4424400fb67c28018d04113bf87f5a2bca3bf97c548b44243c0fb63b0f
b604068d0c103bf97f422bc23bf87c3c8b4424148b7c24408b4c24444083c50483c30483c604894424143bc17c818b5c2420
8b7424240374244c8b44242840035c245089742424e924ffffff8b7c24108b6c241c8b44244c8b5c24608b4c24444703e889
7c2410896c241c3bfb0f8cf3feffff8b7c24688b6c24584f897c24683b7c24540f8dc5feffff8b4424345fc700ffffffff8b
4424345e5dc700ffffffffb85ff0ffff5b83c420c3,4c894c24204c89442418488954241048894c24085355565741544
155415641574883ec188b8424c80000004d8bd94d8bd0488bda83f8010f85b3010000448b8c24a800000044890c24443b8c2
4b80000000f8d66010000448bac24900000008b9424c0000000448b8424b00000008bbc2480000000448b9424a0000000418
bcd410fafc9894c24040f1f84000000000044899424c8000000453bd00f8dfb000000468d2495000000000f1f80000000003
3ed448bf933f6660f1f8400000000003bac24880000000f8d1701000033db85ff7e7e458bf4448bce442bf64503f7904d63c
14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd07f572bca443bd17c50410fb
64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f272bca443bd17c204c8b5c247
8ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b8424b00000008b4c24044c8b5c2
478ffc04183c404898424c8000000413bc00f8c20ffffff448b0c24448b9424a000000041ffc14103cd44890c24894c24044
43b8c24b80000000f8cd8feffff488b5c2468488b4c2460b85ff0ffffc701ffffffffc703ffffffff4883c418415f415e415
d415c5f5e5d5bc38b8424c8000000e9860b000083f8020f858c010000448b8c24b800000041ffc944890c24443b8c24a8000
0007cab448bac2490000000448b8424c00000008b9424b00000008bbc2480000000448b9424a0000000418bc9410fafcd418
bc5894c2404f7d8894424080f1f400044899424c8000000443bd20f8d02010000468d2495000000000f1f80000000004533f
6448bf933f60f1f840000000000443bb424880000000f8d56ffffff33db85ff0f8e81000000418bec448bd62bee4103ef496
3d24903d3807a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f5d412bc8443bc97c554
10fb64b01440fb64a01428d0401443bc87f42412bc8443bc97c3a410fb60b440fb60a428d0401443bc87f29412bc8443bc97
c214c8b5c2478ffc34183c2043bdf7c8a41ffc64503fd03b42498000000e955ffffff8b8424c80000008b9424b00000008b4
c24044c8b5c2478ffc04183c404898424c80000003bc20f8c19ffffff448b0c24448b9424a0000000034c240841ffc9894c2
40444890c24443b8c24a80000000f8dd0feffffe933feffff83f8030f85c4010000448b8c24b800000041ffc944898c24c80
00000443b8c24a80000000f8c0efeffff8b842490000000448b9c24b0000000448b8424c00000008bbc248000000041ffcb4
18bc98bd044895c24080fafc8f7da890c24895424048b9424a0000000448b542404458beb443bda0f8c13010000468d249d0
000000066660f1f84000000000033ed448bf933f6660f1f8400000000003bac24880000000f8d0801000033db85ff0f8e960
00000488b4c2478458bf4448bd6442bf64503f70f1f8400000000004963d24803d1807a03007460440fb64a02438d04164c6
3d84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc
8443bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c27488b4c2478ffc34183c2043bdf7c8a8b8424900
00000ffc54403f803b42498000000e942ffffff8b9424a00000008b8424900000008b0c2441ffcd4183ec04443bea0f8d11f
fffff448b8c24c8000000448b542404448b5c240841ffc94103ca44898c24c8000000890c24443b8c24a80000000f8dc2fef
fffe983fcffff488b4c24608b8424c8000000448929488b4c2468890133c0e981fcffff83f8040f857f010000448b8c24a80
0000044890c24443b8c24b80000000f8d48fcffff448bac2490000000448b9424b00000008b9424c0000000448b8424a0000
0008bbc248000000041ffca418bcd4489542408410fafc9894c2404669044899424c8000000453bd00f8cf8000000468d249
5000000000f1f800000000033ed448bf933f6660f1f8400000000003bac24880000000f8df7fbffff33db85ff7e7e458bf44
48bce442bf64503f7904d63c14d03c34180780300745a450fb65002438d040e4c63d84c035c2470410fb64b028d0411443bd
07f572bca443bd17c50410fb64b01450fb650018d0411443bd07f3e2bca443bd17c37410fb60b450fb6108d0411443bd07f2
72bca443bd17c204c8b5c2478ffc34183c1043bdf7c8fffc54503fd03b42498000000e95effffff8b8424c8000000448b842
4a00000008b4c24044c8b5c2478ffc84183ec04898424c8000000413bc00f8d20ffffff448b0c24448b54240841ffc14103c
d44890c24894c2404443b8c24b80000000f8cdbfeffffe9defaffff83f8050f85ab010000448b8424a000000044890424443
b8424b00000000f8dc0faffff8b9424c0000000448bac2498000000448ba424900000008bbc2480000000448b8c24a800000
0428d0c8500000000898c24c800000044894c2404443b8c24b80000000f8d09010000418bc4410fafc18944240833ed448bf
833f6660f1f8400000000003bac24880000000f8d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14
d03c34180780300745d438d040e4c63d84d03da450fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b014
50fb650018d0411443bd07f462bca443bd17c3f410fb60b450fb6108d0411443bd07f2f2bca443bd17c284c8b5c24784c8b5
42470ffc34183c1043bdf7c8c8b8c24c8000000ffc54503fc4103f5e955ffffff448b4424048b4424088b8c24c80000004c8
b5c24784c8b54247041ffc04103c4448944240489442408443b8424b80000000f8c0effffff448b0424448b8c24a80000004
1ffc083c10444890424898c24c8000000443b8424b00000000f8cc5feffffe946f9ffff488b4c24608b042489018b4424044
88b4c2468890133c0e945f9ffff83f8060f85aa010000448b8c24a000000044894c2404443b8c24b00000000f8d0bf9ffff8
b8424b8000000448b8424c0000000448ba424900000008bbc2480000000428d0c8d00000000ffc88944240c898c24c800000
06666660f1f840000000000448be83b8424a80000000f8c02010000410fafc4418bd4f7da891424894424084533f6448bf83
3f60f1f840000000000443bb424880000000f8df900000033db85ff0f8e870000008be9448bd62bee4103ef4963d24903d38
07a03007460440fb64a02418d042a4c63d84c035c2470410fb64b02428d0401443bc87f64412bc8443bc97c5c410fb64b014
40fb64a01428d0401443bc87f49412bc8443bc97c41410fb60b440fb60a428d0401443bc87f30412bc8443bc97c284c8b5c2
478ffc34183c2043bdf7c8a8b8c24c800000041ffc64503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5
c247803042441ffcd89442408443bac24a80000000f8d17ffffff448b4c24048b44240c41ffc183c10444894c2404898c24c
8000000443b8c24b00000000f8ccefeffffe991f7ffff488b4c24608b4424048901488b4c246833c0448929e992f7ffff83f
8070f858d010000448b8c24b000000041ffc944894c2404443b8c24a00000000f8c55f7ffff8b8424b8000000448b8424c00
00000448ba424900000008bbc2480000000428d0c8d00000000ffc8890424898c24c8000000660f1f440000448be83b8424a
80000000f8c02010000410fafc4418bd4f7da8954240c8944240833ed448bf833f60f1f8400000000003bac24880000000f8
d4affffff33db85ff0f8e89000000448bf1448bd6442bf64503f74963d24903d3807a03007460440fb64a02438d04164c63d
84c035c2470410fb64b02428d0401443bc87f63412bc8443bc97c5b410fb64b01440fb64a01428d0401443bc87f48412bc84
43bc97c40410fb60b440fb60a428d0401443bc87f2f412bc8443bc97c274c8b5c2478ffc34183c2043bdf7c8a8b8c24c8000
000ffc54503fc03b42498000000e94fffffff8b4424088b8c24c80000004c8b5c24780344240c41ffcd89442408443bac24a
80000000f8d17ffffff448b4c24048b042441ffc983e90444894c2404898c24c8000000443b8c24a00000000f8dcefeffffe
9e1f5ffff83f8080f85ddf5ffff448b8424b000000041ffc84489442404443b8424a00000000f8cbff5ffff8b9424c000000
0448bac2498000000448ba424900000008bbc2480000000448b8c24a8000000428d0c8500000000898c24c800000044890c2
4443b8c24b80000000f8d08010000418bc4410fafc18944240833ed448bf833f6660f1f8400000000003bac24880000000f8
d0501000033db85ff0f8e87000000448bf1448bce442bf64503f74d63c14d03c34180780300745d438d040e4c63d84d03da4
50fb65002410fb64b028d0411443bd07f5f2bca443bd17c58410fb64b01450fb650018d0411443bd07f462bca443bd17c3f4
10fb603450fb6108d0c10443bd17f2f2bc2443bd07c284c8b5c24784c8b542470ffc34183c1043bdf7c8c8b8c24c8000000f
fc54503fc4103f5e955ffffff448b04248b4424088b8c24c80000004c8b5c24784c8b54247041ffc04103c44489042489442
408443b8424b80000000f8c10ffffff448b442404448b8c24a800000041ffc883e9044489442404898c24c8000000443b842
4a00000000f8dc6feffffe946f4ffff8b442404488b4c246089018b0424488b4c2468890133c0e945f4ffff
)"
if(A_PtrSize==8)
MCode_ImageSearch:=SubStr(MCode_ImageSearch,InStr(MCode_ImageSearch,",")+1)
else
MCode_ImageSearch:=SubStr(MCode_ImageSearch,1,InStr(MCode_ImageSearch,",")-1)
VarSetCapacity(_ImageSearch,LEN:=StrLen(MCode_ImageSearch)//2,0)
Loop,%LEN%
NumPut("0x" . SubStr(MCode_ImageSearch,(2*A_Index)-1,2),_ImageSearch,A_Index-1,"uchar")
MCode_ImageSearch:=""
DllCall("VirtualProtect","UPtr",&_ImageSearch,"UPtr",VarSetCapacity(_ImageSearch),"uint",0x40,"UPtr*",0)
}
if(sx2<sx1)
return -3001
if(sy2<sy1)
return -3002
if(sx2>(hWidth-nWidth+1))
return -3003
if(sy2>(hHeight-nHeight+1))
return -3004
if(sx2-sx1==0)
return -3005
if(sy2-sy1==0)
return -3006
x:=0,y:=0,E:=DllCall( &_ImageSearch,"int*",x,"int*",y,"UPtr",hScan,"UPtr",nScan,"int",nWidth,"int",nHeight,"int",hStride,"int",nStride,"int",sx1,"int",sy1,"int",sx2,"int",sy2,"int",Variation,"int",sd,"cdecl int")
Return (E==""?-3007:E)
}