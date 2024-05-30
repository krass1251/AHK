@echo off
for /f "tokens=1,2,3 delims= " %%i in ('query session ^| findstr "Active"') do set SessionId=%%k
Tscon %SessionId% /Dest:console