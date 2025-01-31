set OldPath=%path%
path "c:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x86";%path%
inf2cat /driver:"." /os:10_X64
signtool sign /fd sha256 /f fwu.pfx /p 1234 delta.cat
path %oldpath%

pause

rem
rem

set path=C:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x86;C:\Program Files (x86)\Windows Kits\8.1\bin\10.0.18362.0\x86;%PATH%
Inf2Cat.exe /driver:"c:\CapsuleNLH" /os:10_x64
makecert.exe -r -pe -a sha256 -eku 1.3.6.1.5.5.7.3.3 -n CN=Foo -sv fwu.pvk fwu.cer
pvk2pfx.exe -pvk fwu.pvk -spc fwu.cer -spc fwu.cer -pfx fwu.pfx
signtool sign /fd sha256 /f fwu.pfx NLHcapsule.cat