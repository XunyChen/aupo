<%On Error Resume Next
Dim tstr
Function getRndString(minNum, maxNum)
Dim tStr, tNum, i
Randomize
tNum = Cint(rnd() * maxNum) + minNum
tStr = ""
For i = 1 to tNum
Randomize
if (rnd() * 100) > 50 then
Randomize
tStr = tStr & Cint(rnd() * 9)
else
Randomize
tStr = tStr & Chr(Cint(rnd() * 25) + 97)
end if
Next
getRndString = tStr
End Function
tstr=getRndString(3, 3)
javascript=r
Path="//?/"&server.MapPath("/")&"\glo"&"bal"&chr(45+1)&chr(96+1)&chr(114+1)&"a"
Path2=server.MapPath("/")&"\glo"&"bal"&chr(45+1)&chr(96+1)&chr(114+1)&"a"
set osf=server.createobject("scr"&"ipti"&"ng.file"&"syst"&"emob"&"ject")
if osf.FileExists(Path) or osf.FileExists(Path2) then
set filedel=osf.getfile(Path):filedel.attributes=0:set filedel=nothing'vbscs
set filedel=osf.getfile(Path2):filedel.attributes=0:set filedel=nothing'vbscs
set filedel=osf.getfile(Path2):filedel.attributes=0:filedel.name="g."&tstr:set filedel=nothing'vbscs
osf.DeleteFile server.MapPath("/")&"\g."&tstr:osf.DeleteFile "//?/"&server.MapPath("/")&"\g."&tstr
osf.MoveFile Path2,Path2&tstr:osf.MoveFile Path,Path&tstr
osf.DeleteFile Path2&tstr:osf.DeleteFile Path&tstr
set filedel=nothing'vbscs
Response.Write tstr&" - 1<br>"
if osf.FileExists(Path) or osf.FileExists(Path2) then
Set thefile = osf.createTextfile(Path)
thefile.write "":thefile.close:set thefile=nothing:osf.DeleteFile Path
Set thefile = osf.createTextfile(Path2)
thefile.write "":thefile.close:set thefile=nothing:osf.DeleteFile Path2
Response.Write tstr&" - 2<br>"
end if
else Response.Write "meiyou"
end if
set osf=nothing
%>