<!--#include file="inc/AspCms_SettingClass.asp" -->
<%
dim action : action=getForm("action","get")
if action = "login" then
	dim UserName,Password,sql,code,Rs,atype
	UserName = filterPara(getForm("username","post"))
	atype = getForm("atype","post")
	Password = md5(getForm("Password","post"),16)
	code     = getForm("code","post")
	if admincode=1 then
		if code <> Session("Code") then	alertMsgAndGo "����д����֤�����!","-1"
	end if
	if isOutSubmit then  alertMsgAndGo"�Ƿ��ⲿ�ύ����ֹ","-1"

'	User UserGroup
'	LoginName
'Password
'GroupID
'IsAdmin
	sql = "select count(*) from {prefix}User where LoginName = '"& UserName &"' and Password='"&Password&"'"
	Dim rsObj : Set rsObj=Conn.Exec(sql,"r1")
	if rsObj(0)=1 then
	
		
		Set rsObj=Conn.Exec("select IsAdmin, GroupStatus,GroupName, UserStatus, UserID, GroupMenu,GroupSort, LanguageID,adminrand from {prefix}User as a, {prefix}UserGroup as b where LoginName='"&UserName&"' and a.GroupID=b.GroupID","r1")	
		if not rsObj.Eof Then
			if rsObj("IsAdmin")<>1 then alertMsgAndGo"�Բ����㲻�ǹ���Ա��","-1"
			if rsObj("GroupStatus")<>1 then alertMsgAndGo"�Բ����������û����ѱ����ã�","-1"
			if rsObj("UserStatus")<>1 then alertMsgAndGo"�Բ��������˺��ѱ����ã�","-1"
			Session("adminName")=UserName
			Session("GroupName")=rsObj("GroupName")
			'wCookie"adminpwd",getForm("Password","post")
			Session("adminpwd") = getForm("Password","post")
			Session("adminId")=rsObj("UserID")
			Session("groupMenu")=repnull(rsObj("GroupMenu"))
			Session("GroupSort")=repnull(rsObj("GroupSort"))
			'����
			dim LanguageID
			LanguageID=rsObj("LanguageID")

			if isnul(LanguageID) then 				
				set rs=conn.exec("select LanguageID,LanguagePath,Alias from {prefix}Language where IsDefault=1","exe")
				if rs.eof then					
					echoErr err_15,15,"û������Ĭ������"
				else
					LanguageID=rs(0)
				end if
			else 	
				set rs=conn.exec("select LanguageID,LanguagePath,Alias from {prefix}Language where LanguageID="&LanguageID,"exe")				
				LanguageID=rs(0)	
			end if 
			randomize
			dim randnum
			randnum=clng(rnd*99999999)
			Conn.Exec"update {prefix}User set adminrand='"& randnum &"' where UserID="&rsObj("UserID"),"exe"	
			Session("adminrand")=rsObj("adminrand")	
			Session("languageID")=LanguageID			
			Session("LanguagePath")=rs("LanguagePath")
			Session("LanguageAlias")=rs("Alias")
			

			rs.close : set rs=nothing
			Conn.Exec"update {prefix}User set LastLoginTime='"&now()&"',LastLoginIP='"&getIp()&"',LoginCount=LoginCount+1 where UserID="&rsObj("UserID"),"exe"	
			if atype=0 then		
			response.Redirect("index.asp")
			else
			response.Redirect("index_user.asp")	
			end if
		end if
	else
		alertMsgAndGo "�û������������!","-1"
	end if
	rsObj.Close() : set rsObj=Nothing	
elseif action = "logout" then
	Session("adminName")=""
	Session("adminId")=""
	Session("groupMenu")=""
	Session("SceneMenu")=""
	response.Redirect("login.asp"):response.End()
elseif action = "relog" then
	alertMsgAndGo "�Բ���,���ĵ�¼״̬�Ѿ�ʧЧ,�����µ�¼!","login.asp"
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title><%=setting.siteTitle%>-��ҵ��վ����ϵͳ</title>
<link type="text/css" rel="stylesheet" href="css/main.css"/>
<script type="text/javascript" language="javascript">
<!--
	window.onload = function (){
		var txtUserName = document.getElementById("username");
		var txtPassword = document.getElementById("password");
		changeimg();
		var username = readCookie("username");
		if(username!="")
		{
		txtUserName.value = username;
		txtPassword.focus();
		}
		else	txtUserName.focus();
		document.getElementById("code").value = "";
	}
function changeimg(){document.getElementById('SeedImg').src='../inc/checkcode.asp?'+Math.random();}
function writeCookie(name, value, hours){
  var expire = "";
  if(hours != null)  {
    expire = new Date((new Date()).getTime() + hours * 3600000);
    expire = "; expires=" + expire.toGMTString();
  }
  document.cookie = name + "=" + escape(value) + expire;

}
function readCookie(name){
  var cookieValue = "";
  var search = name + "=";
  if(document.cookie.length > 0) { 
    offset = document.cookie.indexOf(search);
    if (offset != -1)  { 
      offset += search.length;
      end = document.cookie.indexOf(";", offset);
      if (end == -1) end = document.cookie.length;
      cookieValue = unescape(document.cookie.substring(offset, end))
    }
  }
  return cookieValue;
}


-->
</script>
</head>

<body>
<div class="login">
	<div class="menus">
    	<div class="public"><a href="http://www.alovestory.cn" target="_blank">ʹ�ð���</a><a href="http://www.alovestory.cn" target="_blank">��ϵ������</a></div>
    </div>
    <div class="box png">
        <form method="post" action="?action=login" onsubmit="writeCookie('username',this.username.value, 1)">
		<input type="hidden" name="gotopage" value="/aspcms/index.asp">
        <input type="hidden" name="dopost" value="login">
        <div class="header">
            <!--<h2 class="logo png"><a href="" target="_blank"></a></h2>-->
            <span class="alt">����Ա��¼</span>
        </div>
        <ul>
            <li><label>�û���</label><input id="username" name="username" type="text" class="text" value=""></li>
            <li><label>�ܡ���</label><input id="password" name="password" type="password" class="text" value=""></li>
			<%if admincode=1 then%>
			<li><label>��֤��</label><input id="code" name="code" type="text" class="text" style="width:120px;" value=""><img src="../inc/checkcode.asp" id="SeedImg" align="absmiddle" style="cursor:pointer; margin-left:5px;height:22px;" border="0" alt="����ˢ��" title="����ˢ��" onclick="changeimg()" /></li>			
			<%end if%>
			<li style="display:none;"><label>����</label><input name="atype" type="radio" value="1"  checked="checked" />�򵥰�  <input name="atype" type="radio" value="0"/>ȫ���ܰ�</li> 
            <li class="submits"><input class="submit" type="submit" name="submit" value="��¼"></li>
        </ul>
		<!--
        <div class="copyright">? 2006 - 2012 | <a href="" target="_blank" title="CMS"></a> |
            <a title="" href="" target="_blank" class="weibo tencent"></a>
        </div>-->
        </form>
    </div>
    <div class="air-balloon ab-1 png" ></div><div class="air-balloon ab-2 png"></div>
    <div class="footer"></div>
</div>
</body>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/fun.base.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<!--[if lt IE 9]>
<script src="js/PIE.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
    if (window.PIE && ( $.browser.version >= 6 && $.browser.version < 10 )){
        $('input.text,input.submit').each(function(){
            PIE.attach(this);
        });
    }
});
</script>
<![endif]-->

<!--[if IE 6]>
<script src="js/DD_belatedPNG.js" type="text/javascript"></script>
<script>DD_belatedPNG.fix('.png')</script>
<![endif]-->
</html>
