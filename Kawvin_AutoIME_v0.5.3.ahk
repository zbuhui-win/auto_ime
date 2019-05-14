/* Kawvin_AutoIME（根据设置自动切换输入法）
    脚本: Kawvin_AutoIME
    作用: 根据设置自动切换输入法
    作者: Kawvin
	改编自：lspcieee <lspcieee@gmail.com>，心如止水<QQ:2531574300>   <Autohotkey高手群（348016704)>
    版本: 0.5.3_2018.10.07
	
	【版本: 0.5.3_2018.10.07_更新内容】
	1、修复输入法提示（1.1增加中文时单击Shift的提示，1.2增加手动切换输入法时光标提示）
	2、加入双击Shift切换为中文
	3、增加其它软件如ps、cad启动时的自动化处理（扩展功能）
	4、其它调教
	
	【版本: 0.5_2018.09.30_更新内容】
	1、修改输入法提示为鼠标跟随光标提示，感谢 Space<105224583<moonhuahua@foxmail.com>>提供的代码及测试
	
	【版本: 0.4.1_2018.09.30_更新内容】
	1、修正全局及编辑器内，切换输入法热键，中文：vff，英文：vjj
	
	【版本: 0.4_2018.09.29_更新内容】
	1、修正Win7系统下切换输入法的BUG，感谢Vito.无关风月<l_x_93@sina.com> <QZ/VimD/TC/AHK群(271105729)>,小猛<skc2015@163.com> 根据程序设置输入法
	2、增加Tab键（原仅鼠标左键）在指定程序指定控件内指定输入法功能
	3、增加了托盘右键设置中文/英文输入法的功能
	
	【版本: 0.2_2018.09.28_更新内容】
	1、增加在指定的程序指定控件内指定输入法，在[切换英文窗口控件]、[切换中文窗口控件]下添加项目，如：Item=ahk_class TFoxComposeForm.UnicodeClass|TFMEdit.UnicodeClass1
	2、增加切换提示功能
	3、增加【复制激活控件名称到剪贴板】功能，【托盘右键】-勾选【复制激活控件名称到剪贴板】
	
   【 设置方法】：
		1.【托盘右键】-【检测键盘布局号码】，记录本机上的中文输入法及英文输入法的代码
		2.【托盘右键】-【打开SPY】，将要设置窗体的ahk_exe或ahk_class记录下来
		3.【托盘右键】-【编辑配置文件】，在相应的内容项目下填写内容
		4. 将本脚本开机启动。
	【使用方法】：
		1.相应程序打开及切换时自动切换输入法;
		2.在编辑器窗口内
			在VS内，输入' （'+空格）自动进行注释模式，切换为中文
			在Scite4内，输入; （分号+空格）自动进行注释模式，切换为英文
			在VS和Scite4内，
				回车，切换为中文
				vjj，手动切换为英文
				vff，手动切换为中文
		3.全局手动切换
			vjj，手动切换为英文
			vff，手动切换为中文
*/

;【改编者信息】	;{
	; 脚本名称：IME2
	; 脚本版本号 v1.04
	; AHK版本：		1.1.30
	; 语言：		中文
	; 改编者：心如止水<QQ:2531574300>   <Autohotkey高手群（348016704)>
	; 脚本功能：	可根据五种不同场景,自动切换输入法
	; ^_^： 如果您有什么新的想法,或者有什么改进意见,欢迎加我的QQ,一起探讨改进 ：^_^
	;---------------------------------------------------
	; 版本信息
	; v0.3：在原作基础上增加了检测功能，切换更智能了
	; v1.0：9月24日 切换方式暂改为"切换键盘布局",切换更智能，更流畅,几乎不会出错
	; v1.01：9月24日 默认停掉编辑器内手动切换 这个非常容易误触，还是采取全局切换的那个比较好,修复了窗口切换时切换输入法失效的问题
	; v1.02：9月24日 在 编辑器内/全局手动时 默认停掉提示
	; v1.03：9月24日 1,针对中文输入法英文模式的情况，进行了针对性优化(仍需要您手动检测情况，填写代号) 2,输入法切换方法支持忽略延迟
	; v1.04：9月25日 1,修复了"中文布局+中文输入法下切换"时,"通知提示消失/忽略延迟不起作用"的问题 2,把注释放到了前面
	;---------------------------------------------------
	; v1.0使用说明
	; ### 切换方法改为更稳定的"切换键盘布局方法",还可以在其它键盘布局上放英文输入法，提高效率(v1.0)
	; ### 如何设置键盘布局？
	; 可以去百度或谷歌上搜一下,默认的大概是中文(简体),新增加一个英文(美国)
	; ### 如何使用？
	; 切换和检测的方法,都需要特定的号码,但是这个号码是不一样的,你需要获取，然后更改
	; 1,启用《键盘布局号码 - 手动检测工具》,分别检测你的计算机上两个键盘布局的号码是多少,然后记录下来，根据结果修改切换+检测方法
	; 2,另外 启用《输入法中英文代号-手动检测工具》,分别检测你计算机上中英文的输入法状态号码是多少,然后记录下来，根据结果修改一下检测方法(因为这个版本的原理为切换键盘布局，所以这个在切换方法中没有利用，只需要改检测方法就可以)
	; ### 小技巧
	; 英文输入法在打字的时候可以给出英文提示,有点类似于IDE的效果,很多人工作中和英语打交道比较少,偶尔用到之后，发现很多词都忘了，需要翻字典,有了英文输入法这种现象就大大的改善了
	; 英文输入法可以用一下Triivi ,口碑还是不错的
	; 检测方法以及切换思路来自 https://autohotkey.com/board/topic/18343-dllcall-loadkeyboardlayout-problem/
	; 感谢 无关风月 的帮助测试,将来还会持续更新优化
;}

;【原作者信息如下】	;{
	; AHK版本：		1.1.29.01
	; 语言：		中文
	; 作者：		lspcieee <lspcieee@gmail.com>
	; 网站：		http://www.lspcieee.com/
	; 脚本功能：	自动切换输入法
	; ---------------------------------------------------
	; # 关于原作者：
	; 原作者的脚本网址和使用方法介绍 https://faxian.appinn.com/747
	; 我这个脚本改进自该作者，所以先要看原来的说明文档才可以懂
;}

Label_ScriptSetting:	;{ 脚本前参数设置
	Process, Priority, , High						;脚本高优先级
	;~ #NoTrayIcon 									;隐藏托盘图标
	#NoEnv											;不检查空变量是否为环境变量
	#Persistent										;让脚本持久运行(关闭或ExitApp)
	#SingleInstance Force						;跳过对话框并自动替换旧实例
	#WinActivateForce							;强制激活窗口
	#MaxHotkeysPerInterval 200			;时间内按热键最大次数
	#HotkeyModifierTimeout 100 		;按住modifier后（不用释放后再按一次）可隐藏多个当前激活窗口
	;~ SetBatchLines -1							;脚本全速执行
	SetControlDelay -1							;控件修改命令自动延时,-1无延时，0最小延时
	CoordMode Menu Window				;坐标相对活动窗口
	CoordMode Mouse Screen				;鼠标坐标相对于桌面(整个屏幕)
	ListLines,Off           							;不显示最近执行的脚本行
	SendMode Input								;更速度和可靠方式发送键盘点击
	SetTitleMatchMode 2						;窗口标题模糊匹配;RegEx正则匹配
	DetectHiddenWindows On				;显示隐藏窗口
;}

Label_DefVar:	;{ 设置主参数
	global AppVer
	AppVer=Kawvin_AutoIME_0.5.3
	global CopyControl:=0
	global SelectCode:=""
	global arrow_en :="" 					;英文,白标C:\Windows\Cursors\aero_arrow_xl.cur
	global arrow_cn :="" 					;中文,黑标C:\Windows\Cursors\arrow_rl.cur
	
	global INI
	INI=%A_ScriptDir%\Kawvin_AutoIME.ini
	global CN_Code:=""
	global EN_Code:=""
	global CN_Control_Array:=[]
	global EN_Control_Array:=[]
	IfNotExist,%INI%
	{
		FileAppend,[基本设置]`n,%INI%
		FileAppend,中文代码=0x8040804`n,%INI%
		FileAppend,英文代码=0x4090409`n`n,%INI%
		;FileAppend,中文光标=beam_Cn_R.cur`n`n,%INI%
		;FileAppend,英文光标=beam_En_G.cur`n`n,%INI%
		FileAppend,[新开中文窗口]`n,%INI%
		FileAppend,Item=`n`n,%INI%
		FileAppend,[新开英文窗口]`n,%INI%
		FileAppend,Item=`n`n,%INI%
		FileAppend,[切换中文窗口]`n,%INI%
		FileAppend,Item=`n`n,%INI%
		FileAppend,[切换英文窗口]`n,%INI%
		FileAppend,Item=`n`n,%INI%
		FileAppend,[编辑器窗口]`n,%INI%
		FileAppend,Item=`n`n,%INI%
		FileAppend,[切换英文窗口控件]`n,%INI%
		FileAppend,Item=`n`n,%INI%
		FileAppend,[切换中文窗口控件]`n,%INI%
		FileAppend,Item=`n`n,%INI%
	}
;}

Label_ReadINI: ;{ 读取INI分组
	;【读取键盘】
	iniread,CN_Code,%INI%,基本设置,中文代码,%A_Space%
	iniread,EN_Code,%INI%,基本设置,英文代码,%A_Space%
	;~ global arrow_en :=A_ScriptDir . "\Lib\beam_En_R.cur" 					;英文,白标C:\Windows\Cursors\aero_arrow_xl.cur
	;~ global arrow_cn :=A_ScriptDir . "\Lib\beam_Cn_B.cur" 					;中文,黑标C:\Windows\Cursors\arrow_rl.cur
	;iniread,arrow_en,%INI%,基本设置,英文光标,beam_En_G.cur
	;iniread,arrow_cn,%INI%,基本设置,中文光标,beam_Cn_R.cur
	;arrow_en:=A_ScriptDir .  "\Lib\" . arrow_en
	;arrow_cn:=A_ScriptDir .  "\Lib\" . arrow_cn
	;【读取注释符，生成注释符热键】
	iniread,CommentStr,%INI%,基本设置,注释符,%A_Space%
	
	;【读取分组】
	iniread,INI_CN,%INI%,新开中文窗口
	IniRead,INI_EN,%INI%,新开英文窗口
	iniread,INI_CN32772,%INI%,切换中文窗口
	IniRead,INI_EN32772,%INI%,切换英文窗口
	IniRead,INI_Editor,%INI%,编辑器窗口
	IniRead,INI_CN_Control,%INI%,切换中文窗口控件
	IniRead,INI_EN_Control,%INI%,切换英文窗口控件
	;分组配置-新开中文窗口
	Loop,parse,INI_CN,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		if (MyVar_Key && MyVar_Val ) 
			GroupAdd,cn,%MyVar_Val%
	}
	;分组配置-新开英文窗口
	Loop,parse,INI_EN,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		if (MyVar_Key && MyVar_Val ) 
			GroupAdd,en,%MyVar_Val%
	}
	;分组配置-切换中文窗口
	Loop,parse,INI_CN32772,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		if (MyVar_Key && MyVar_Val ) 
			GroupAdd,cn32772,%MyVar_Val%
	}
	;分组配置-切换中文窗口
	Loop,parse,INI_EN32772,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		if (MyVar_Key && MyVar_Val ) 
			GroupAdd,en32772,%MyVar_Val%
	}
	;分组配置-编辑器分组
	Loop,parse,INI_Editor,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		if (MyVar_Key && MyVar_Val ) 
			GroupAdd,editor,%MyVar_Val%
	}
	;分组配置-切换中文窗口控件
	Loop,parse,INI_CN_Control,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		MyVar_Array:=StrSplit(MyVar_Val,"|")
		if (MyVar_Key && MyVar_Array[1] && MyVar_Array[2] ) {
			GroupAdd,MyControl,% MyVar_Array[1]
			CN_Control_Array.push(MyVar_Array[2])
		}
	}
	;分组配置-切换英文窗口控件
	Loop,parse,INI_EN_Control,`n,`r
	{
		if (A_LoopField="")
			continue
		MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
		MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
		MyVar_Array:=StrSplit(MyVar_Val,"|")
		if (MyVar_Key && MyVar_Array[1] && MyVar_Array[2] ) {
			GroupAdd,MyControl,% MyVar_Array[1]
			EN_Control_Array.push(MyVar_Array[2])
		}
	}
;}

Label_Main:	;{ 主运行脚本
	;创建菜单
	CreatTrayMenu()
	; # 监控消息回调ShellMessage，并自动设置输入法(监测窗口切换以及打开的方法)
	Gui +LastFound
	hWnd := WinExist()
	DllCall( "RegisterShellHookWindow", UInt,hWnd )
	MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
	OnMessage( MsgNum, "ShellMessage")
	
	;~ OnMessage(0x201, "WM_LBUTTONDOWN")	;左键按下 WM_LBUTTONDOWN
	;~ OnMessage(0x201, "WM_LBUTTONDOWN")

;}

return

~LButton::	;{复制激活控件名称到剪贴板
	Sleep 200
	AutoCursor()
	if !CopyControl
		return
	;获取当前控件
	sleep,50
	ControlGetFocus, ctrl, A
	Clipboard:=ctrl
return
;}
;~^Space::		;1）当前指针不是光标则不设置光标；2）当前输入法语言与上次一样则不设置光标
;~#space::
;~ ~Shift::
;~ ~LButton::
	Sleep 200
	AutoCursor()
return

Label_全局手动切换方法: ;{
:Z?*:vff::
	setChineseLayout(1)
return
:Z?*:vjj::
	setEnglishLayout(1)
return
;}

~LAlt::
	setChineseLayout(1)
return

;【功能】双击shift切换输入法成中文
~LShift::
if  pressesCount>0
{
	pressesCount+=1 
	return
}
pressesCount=1
SetTimer,WaitKeys,400
return
WaitKeys:
SetTimer,WaitKeys,off
if pressesCount=1
{
	If DllCall("GetKeyboardLayout", "UINT",DllCall("GetWindowThreadProcessId", "Ptr",WinActive("A"), "Ptr",0), "UInt") != 67699721
	{
		if(arrowarrow:=!arrowarrow){
			OCR_IBEAM := 32513
			arrow_cn_en := A_workingdir . "\Lib\beam_Cn_En.cur"
			beam_Cn_En := DllCall("LoadCursorFromFile", "Str",arrow_cn_en, "Ptr")
			hCursor := DllCall("CopyIcon", "Ptr", beam_Cn_En, "Ptr")
			DllCall( "SetSystemCursor", "Ptr", hCursor, "Int", OCR_IBEAM )
		}else{
			OCR_IBEAM := 32513
			arrow_cn_en := A_workingdir . "\Lib\beam_Cn_RB.cur"
			beam_Cn_En := DllCall("LoadCursorFromFile", "Str",arrow_cn_en, "Ptr")
			hCursor := DllCall("CopyIcon", "Ptr", beam_Cn_En, "Ptr")
			DllCall( "SetSystemCursor", "Ptr", hCursor, "Int", OCR_IBEAM )
		}
	}
	else
	AutoCursor()
}
if pressesCount=2
{
	setChineseLayout(1)
	;~ AutoCursor()
}
pressesCount=0
return
 

IMELA_GET(){ ;激活窗口键盘布局检测方法,减少了不必要的切换,切换更流畅了
  SetFormat, Integer, H
  WinGet, WinID,, A
  ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
  InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID)
  ;~ MsgBox, %InputLocaleID%
  return %InputLocaleID%
}

IME_GET(WinTitle=""){ ;借鉴了某日本人脚本中的获取输入法状态的内容,减少了不必要的切换,切换更流畅了
;-----------------------------------------------------------
; IMEの状態の取得
;    対象： AHK v1.0.34以降
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;-----------------------------------------------------------
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

setChineseLayout(s=0,h=1,force=1){	;中文简体键盘布局切换主方法，默认s=0关闭提示,s=1为打开提示;h=0忽略延迟,h=1打开默认延迟
	global CN_Code
	global EN_Code
	;智能检测,如果发现已经是中文,则不切换
	If (IMELA_GET()=CN_Code && force=0) {
		;~ ShowStatus("当前：【中文】")
		;~ ShowToolTip("【中文】")
		AutoCursor()
		;如果发现虽然是中文的键盘布局,但切换到了内置英文模式,那么也是要改的,改的方法很简单粗暴,切成英文，再切成中文,如果你有快捷键也可以用，但不一定比这个更稳
		If (IME_GET()=0){
			;~ MsgBox,% h
			if (h=1){
				Sleep,30
			}
			PostMessage, 0x50,, %EN_Code%,, A
			if (h=1){
				Sleep,30
			}
			PostMessage, 0x50,, %CN_Code%,, A
			if (s=1){
				;~ ShowStatus("切换到【中文】")
				;~ ShowToolTip("【中文】")
				AutoCursor()
			}
			return
		}
		return
	}
	
	if (h=1){
		Sleep,120
	}
	
	PostMessage, 0x50,, %CN_Code%,, A
	if (h=1){
		Sleep,35
	}
	if (s=1){
		;~ ShowStatus("切换到【中文】")
		;~ ShowToolTip("【中文】")
		AutoCursor()
	}
	return
}

setEnglishLayout(s=0,h=1,force=1){ ;英文美国键盘布局切换主方法，默认s=0关闭提示,s=1为打开提示;h=0忽略延迟,h=1打开默认延迟
	global CN_Code
	global EN_Code
	;智能检测,如果发现已经是英文,则不切换
	If (IMELA_GET()=EN_Code && force=0){
		;~ ShowStatus("当前：【英文】")
		;~ ShowToolTip("【英文】")
		AutoCursor()
	return
	}

	if (h=1){
		Sleep,120
	}
	
	PostMessage, 0x50,, %EN_Code%,, A
	if (h=1){
		Sleep,35
	}
	if (s=1){
		;~ ShowStatus("切换到【英文】")
		;~ ShowToolTip("【英文】")
		AutoCursor()
	}
	return
}

ShellMessage( wParam,lParam ) {
	;1 顶级窗体被创建 
	;2 顶级窗体即将被关闭 
	;3 SHELL 的主窗体将被激活 
	;4 顶级窗体被激活 
	;5 顶级窗体被最大化或最小化 
	;6 Windows 任务栏被刷新，也可以理解成标题变更
	;7 任务列表的内容被选中 
	;8 中英文切换或输入法切换 
	;9 显示系统菜单 
	;10 顶级窗体被强制关闭 
	;11 
	;12 没有被程序处理的APPCOMMAND。见WM_APPCOMMAND 
	;13 wParam=被替换的顶级窗口的hWnd 
	;14 wParam=替换顶级窗口的窗口hWnd 
	;&H8000& 掩码 
	;53 全屏
	;54 退出全屏
	;32772 窗口切换
If ( wParam = 1 )	{
	Sleep, 100
		IfWinActive,ahk_group cn
		{
			setChineseLayout(1)			;~ PostMessage, 0x50, 0, 0x8040804, , A	;0x8040804=134481924
			return
		}
		IfWinActive,ahk_group en
		{
			setEnglishLayout(1)
			return
		}
	;~ Sleep, 500
		IfWinActive ahk_class Photoshop
		{
		Loop 10
		{
			Sleep 200
			wingettitle, ut, ahk_class Photoshop
			if RegExMatch(ut, "2015$")
				continue
			else
				Break
		}
		;~ WinWaitActive ahk_class Photoshop, , 5
		PostMessage, 0x50, 0, 0x4090409, , A		;切换为英文0x4090409=67699721
		;~ Sleep 200
		send, ^j
		send, ![
		Sleep, 100
		Send, {F4}
		send, !]
		return
		}
		IfWinActive ahk_class AfxMDIFrame110u			;AutoCAD
		{
		;~ Sleep 2000
		WinWaitActive ahk_class AfxMDIFrame110u, , 9			;AutoCAD
		Sleep 100
		DPICAD :=BG_GetDPI()
		if DPICAD = 1920x1080
			WinMove, ahk_class AfxMDIFrame110u, , 70, 0, 1850, 1080
		else if DPICAD = 1600x900
			WinMove, ahk_class AfxMDIFrame110u, , 50, 0, 1550, 900
		return
		}
	}
If ( wParam = 32772 )	{
		IfWinActive,ahk_group cn32772
		{
			setChineseLayout(1)
			return
		}
		IfWinActive,ahk_group en32772
		{
			setEnglishLayout(1)
			return
		}
		IfWinActive,ahk_class NUIDialog
		{
		WinWaitActive ahk_class NUIDialog, , 2
		if !ErrorLevel
			Send, {Tab}
		return
		}
	}
}

Label_编辑器内输入法切换方案:	;{
	/*
	## 切换逻辑简述(该逻辑适用于VB以及Scite4,如果您使用的是其他语言，需要针对性修改)
	分为自动场景和手动场景
	中文自动切换场景:1,输入单行注释符时（;或'）时,按下空格，切换为中文,便于加汉语注释
	英文自动切换场景： 输入回车,代表切换到下一个语句,所以默认重置为英文
	中英文手动切换方法：1,全局方法是热字串;vff(中文);vjj(英文)
	*/
	#IfWinActive,ahk_group editor
		;Scite4专用
		:*:`; ::
		:*:`； ::
			;`;加空格 时 切换到中文输入法
			sendbyclip(";")
			setChineseLayout(1)
		return
		
		;VB专用
		:*:`' ::
		:*:`’ ::
			;`'加空格 时 切换到中文输入法
			sendbyclip("'")
			setChineseLayout(1)
		return
		
		;~ :*:`n::
		Enter::
			;回车 时 切换的英文输入法
			setEnglishLayout(1)
			SendInput `n
		return
		
		;~ ;TCL专用
		;~ :*:# ::
			;~ ;# 加空格 时 切换到中文输入法
			;~ sendbyclip("#")
			;~ setChineseLayout(1)
		;~ return
		
		;~ ;C++专用
		;~ :*:// ::
			;~ ;//加空格 时 切换到中文输入法
			;~ sendbyclip("//")
			;~ setChineseLayout(1)
		;~ return
		
		; ## 编辑器内输入法手动切换
		;~ :Z?*:`;`;::
		:Z?*:vjj::
			;两个分号时 切换的英文输入法
			setEnglishLayout(1)
		return
		
		;~ :Z?*:  ::
		:Z?*:vff::
			;输入两个空格 切换的中文输入法
			;~ setEnglishLayout()
			setChineseLayout(1)
		return
		
		


/* 	; C# 专用注释方法
 * 	:Z*:///::
 * 		;///注释时 切换到中文输入法（也可以输入///加空格）
 * 		setEnglishLayout()
 * 		sendbyclip("//")
 * 		SendInput /
 * 		setChineseLayout()
 * 	return
 */

/* 	:*:" ::
 * 		;引号加空格 时 切换到中文输入法
 * 		;~ setEnglishLayout()
 * 		SendInput "
 * 		setChineseLayout()
 * 	return
 */

/* 	:*:`;`n::
 * 		;分号加回车 时 切换的英文输入法
 * 		setEnglishLayout()
 * 		sendbyclip(";")
 * 		SendInput `n
 * 	return
 */
	#IfWinActive
;}

窗体控件指定输入法切换: ;{
	#IfWinActive,ahk_group MyControl
		~LButton::
		~Tab::
			;获取当前控件
			sleep,50
			ControlGetFocus, ctrl, A
			;~ msgbox % ctrl
			if CopyControl
				Clipboard:=ctrl
			loop,% EN_Control_Array.Length()
			{
				;指定英文输入法的窗体下的控件
				if (ctrl=EN_Control_Array[A_index]){
					setEnglishLayout(1)
					break
				}
			}
			loop,% CN_Control_Array.Length()
			{
				;指定中文输入法的窗体下的控件
				if (ctrl=CN_Control_Array[A_index]){
					setChineseLayout(1)
					break
				}
			}
		return
	#IfWinActive
return
;}

ShowToolTip(Msg:=""){	;显示切换或当前的输入法状态
	ToolTip, %Msg%, A_CaretX, A_CaretY - 40
	SetTimer, Timer_RemoveToolTip, 3000
	return
	
	Timer_RemoveToolTip:  ;移除ToolTip
		SetTimer, Timer_RemoveToolTip, Off
		ToolTip
	return
}

ShowStatus(Msg:=""){	;显示切换或当前的输入法状态
	global MyText1
	CustomColor = EEAA99
	try
		Gui,1:Destroy
	Gui,1:new
	
	Gui, 1:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
	Gui, 1:Color, %CustomColor%
	Gui, 1:Font, s32
	Gui, 1:Add, Text, vMyText1 cLime, 　　　　　　　　
	;~ Gui, 1:Add, Text, vMyText2 cLime, 　　　　　　　　
	;~ Gui, 1:Add, Text, vMyText3 cLime, 　　　　　　　　
	;~ Gui, 1:Add, Text, vMyText4 cLime, 　　　　　　　　
	WinSet, TransColor, %CustomColor% 150
	GuiControl,, MyText1, %Msg%
	SetTimer, Timer_MsgShow, 3000
	Gui, 1:Show
	return
	
	Timer_MsgShow:
		SetTimer,Timer_MsgShow,Off
		try
			Gui,1:Destroy
	return
Return
}

sendbyclip(var_string) { ;从剪贴板输入到界面
    ClipboardOld = %ClipboardAll%
    Clipboard =%var_string%
	ClipWait
    send ^v
    sleep 99
    Clipboard = %ClipboardOld%  ; Restore previous contents of clipboard.
}

/*Function：CreatTrayMenu	【作用：创建托盘菜单】
    函数: CreatTrayMenu
    作用：创建托盘菜单
    作者: Kawvin
    版本: 0.1
    使用方法：
*/
CreatTrayMenu(){
	global AppVer
	global INI
	try
		Menu, Tray, Icon,%A_ScriptDir%\Lib\IME.ico
	Menu, Tray, NoStandard        ;自定义菜单放在标准菜单上面
	Menu, tray, add, 编辑配置文件,TrayHandle_EditINI
	Menu, tray, add, 打开SPY,TrayHandle_RunSPY
	Menu, tray, add ; 分隔符
	;~ Menu, tray, add, 检测输入法中英文代号,TrayHandle_手动检测输入法中英文代号
	;~ Menu, tray, add, 手动检测输入法代码,TrayHandle_手动检测输入法代码
	;~ Menu, tray, add, 检测键盘布局号码,TrayHandle_手动检测键盘布局号码
	Menu, tray, add, 设置中文输入法,TrayHandle_设置中文输入法
	Menu, tray, add, 设置英文输入法,TrayHandle_设置英文输入法
	Menu, tray, add ; 分隔符
	;Menu, tray, add, 设置中文光标,TrayHandle_设置中文光标
	;Menu, tray, add, 设置英文光标,TrayHandle_设置英文光标
	Menu, tray, add ; 分隔符
	Menu, tray, add, 复制激活控件名称到剪贴板,TrayHandle_复制激活控件名称到剪贴板
	Menu, tray, add ; 分隔符
	Menu, tray, add, 重启脚本,TrayHandle_ReLoad
	Menu, tray, add ; 分隔符
	Menu, tray, add, 退出,TrayHandle_Exit
	Menu, tray, Tip, %AppVer%
	Menu, tray, Default,编辑配置文件
	return
	
	TrayHandle_EditINI:
		try {
			RunWait,Notepad++.exe %INI%
			
		} catch e {
			RunWait,Notepad.exe %INI%
		}
		Reload
	return
	
	TrayHandle_RunSPY:
		try
			run,%A_ScriptDir%\AU3_Spy.exe
		catch e
			msgbox,未发现Au3_Spy程序
	return
	
	TrayHandle_手动检测输入法中英文代号:
	;::`;ce::
		Clipboard:= IME_GET()
		MsgBox,% "输入法代号：" IME_GET() "`n`n已复制到剪贴板"
	return
	

	TrayHandle_手动检测键盘布局号码:
	;F11::
		SetFormat, Integer, H
		WinGet, WinID,, A
		ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
		InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID)
		Clipboard:=InputLocaleID
		MsgBox, 键盘布局号码：%InputLocaleID%`n`n已复制到剪贴板
	Return
	
	TrayHandle_设置中文输入法:
		GetSelectInput()
		IniWrite,%SelectCode%,%INI%,基本设置,中文代码
		Reload
	return
	
	TrayHandle_设置英文输入法:
		GetSelectInput()
		IniWrite,%SelectCode%,%INI%,基本设置,英文代码
		Reload
	return
	
	;TrayHandle_设置中文光标:
		;SetCursorCorlor("cn")
		Reload
	return
	
	;TrayHandle_设置英文光标:
		;SetCursorCorlor("en")
		Reload
	return
	
	MyRightMenu_Hanlder_CnCursor:
		sel:=RegExMatch(A_ThisMenuItem,"O)(\[.*?\])",m)
		SelectCode:=m[1]
		SelectCode:=StrReplace(SelectCode,"[","")
		SelectCode:=StrReplace(SelectCode,"]","")
		;~ msgbox % SelectCode
	return
	return
	TrayHandle_复制激活控件名称到剪贴板:
		if (CopyControl=0){
			Menu, tray, check, 复制激活控件名称到剪贴板
			CopyControl:=1
		} else {
			Menu, tray, Uncheck, 复制激活控件名称到剪贴板
			CopyControl:=0
		}
	return
	
	TrayHandle_ReLoad:
		Reload
	return
	
	TrayHandle_Exit:
		ExitApp
	return
}

SetCursorCorlor(Lang:="cn") { ;设置光标颜色
	global arrow_en
	global arrow_cn
	Menu, MyRightMenu, Add
	Menu, MyRightMenu, DeleteAll
	if (Lang="cn")  
		Lang:="中文："
	else
		Lang:="英文："
	Menu, MyRightMenu, Add, %Lang%红色,MyRightMenu_Hanlder_SetCursor
	Menu, MyRightMenu, Add, %Lang%绿色,MyRightMenu_Hanlder_SetCursor
	Menu, MyRightMenu, Add, %Lang%蓝色,MyRightMenu_Hanlder_SetCursor
	Menu, MyRightMenu, Add, %Lang%黄色,MyRightMenu_Hanlder_SetCursor
	Menu, MyRightMenu, Add, %Lang%紫色,MyRightMenu_Hanlder_SetCursor
	Menu, MyRightMenu, Add, %Lang%天蓝色,MyRightMenu_Hanlder_SetCursor
	Menu, MyRightMenu,show
	return

	MyRightMenu_Hanlder_SetCursor:
		if instr(A_ThisMenuItem,"中文") {

			if (A_ThisMenuItemPos=1)
				arrow_cn:="beam_Cn_R.cur"
			else if (A_ThisMenuItemPos=2)
				arrow_cn:="beam_Cn_G.cur"
			else if (A_ThisMenuItemPos=3)
				arrow_cn:="beam_Cn_B.cur"
			else if (A_ThisMenuItemPos=4)
				arrow_cn:="beam_Cn_RG.cur"
			else if (A_ThisMenuItemPos=5)
				arrow_cn:="beam_Cn_RB.cur"
			else if (A_ThisMenuItemPos=6)
				arrow_cn:="beam_Cn_GB.cur"

			IniWrite,%arrow_cn%,%INI%,基本设置,中文光标
			arrow_cn:=A_ScriptDir . "\Lib\" . arrow_cn
		} else {
			;if (A_ThisMenuItemPos=1)
			;	arrow_en:="beam_En_R.cur"
			;else if (A_ThisMenuItemPos=2)
			;	arrow_en:="beam_En_G.cur"
			;else if (A_ThisMenuItemPos=3)
			;	arrow_en:="beam_En_B.cur"
			;else if (A_ThisMenuItemPos=4)
			;	arrow_en:="beam_En_RG.cur"
			;else if (A_ThisMenuItemPos=5)
			;	arrow_en:="beam_En_RB.cur"
			;else if (A_ThisMenuItemPos=6)
			;	arrow_en:="beam_En_GB.cur"
			;IniWrite,%arrow_en%,%INI%,基本设置,英文光标
			;arrow_en:=A_ScriptDir .  "\Lib\" . arrow_en
		}
		;~ msgbox % SelectCode
	return
}

GetSelectInput(){	;获取选中的输入法的代码
	global SelectCode
	;~ ^F11::
		;以下代码参考自小猛<skc2015@163.com> 根据程序设置输入法
		HKLnum:=DllCall("GetKeyboardLayoutList","uint",0,"uint",0)
		VarSetCapacity( HKLlist, HKLnum*4, 0 )
		DllCall("GetKeyboardLayoutList","uint",HKLnum,"uint",&HKLlist)
		loop,%HKLnum%
		{
			SetFormat, integer, hex
			HKL:=NumGet( HKLlist,(A_Index-1)*4 )
			StringTrimLeft,Layout,HKL,2
			Layout:= Layout=8040804 ? "00000804" : Layout
			Layout:= Layout=4090409 ? "00000409" : Layout
			RegRead,IMEName,HKEY_LOCAL_MACHINE,SYSTEM\CurrentControlSet\Control\Keyboard Layouts\%Layout%,Layout Text
			SetFormat, integer, D 
			;IniWrite, %Layout%, %A_WorkingDir%\其他配置.ini, %A_Index%, 编号
			Layout:= Layout=00000804 ? "08040804" : Layout
			Layout:= Layout=00000409 ? "04090409" : Layout
			Layout:= "0x" . Layout
			Menu, MyRightMenu, Add, %IMEName%[%Layout%],MyRightMenu_Hanlder_GetSelect
		}
		Menu,MyRightMenu,show
	return

	MyRightMenu_Hanlder_GetSelect:
		sel:=RegExMatch(A_ThisMenuItem,"O)(\[.*?\])",m)
		SelectCode:=m[1]
		SelectCode:=StrReplace(SelectCode,"[","")
		SelectCode:=StrReplace(SelectCode,"]","")
		;~ msgbox % SelectCode
	return
}

AutoCursor(){	;自动切换光标并显示自定义输入法光标，本段代码来自 Space<105224583<moonhuahua@foxmail.com>>
	global arrow_en
	global arrow_cn
	static OCR_IBEAM := 32513			;static 静态变量只会在脚本启动时设置一次，之后每次调用函数不会重新设置。
	;~ static arrow_en :=A_ScriptDir . "\Lib\aero_en.cur" 					;英文,白标C:\Windows\Cursors\aero_arrow_xl.cur
	;~ static arrow_cn :=A_ScriptDir . "\Lib\aero_cn.cur" 					;中文,黑标C:\Windows\Cursors\arrow_rl.cur
	;~ static hbeam_en := DllCall("LoadCursorFromFile", "Str",arrow_en, "Ptr")
	;~ static hbeam_cn := DllCall("LoadCursorFromFile", "Str",arrow_cn, "Ptr")
	global hbeam_en := DllCall("LoadCursorFromFile", "Str",arrow_en, "Ptr")
	global hbeam_cn := DllCall("LoadCursorFromFile", "Str",arrow_cn, "Ptr")
	static last_lang

	ConvMode := IME_GetConvMode()
	;~ if !(((ConvMode != 0) and (ConvMode != 1)) or (A_Cursor = "IBeam"))
	;~ ;if (A_Cursor != "IBeam") 			; 当前指针不是光标则返回
	;~ {
		;~ SPI_SETCURSORS := 0x57
		;~ DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
		;~ return
	;~ }

	idThread := DllCall("GetWindowThreadProcessId", "Ptr",WinActive("A"), "Ptr",0)
	HKL := DllCall("GetKeyboardLayout", "UINT",idThread, "UInt")
	lang := (HKL = 67699721) ? "en" : "cn"

	if (last_lang != lang) {
		hCursor := DllCall("CopyIcon", "Ptr",hbeam_%lang%, "Ptr")
		DllCall( "SetSystemCursor", "Ptr",hCursor, "Int",OCR_IBEAM )
		last_lang := lang
	}
}

IME_GetConvMode(WinTitle="A")   { ;IME_GetConvMode		中文输入法内：英268435456中268436481，本段代码来自 Space<105224583<moonhuahua@foxmail.com>>
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}
    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x001   ;wParam  : IMC_GETCONVERSIONMODE
          ,  Int, 0)      ;lParam  : 0
}

;~ ^!F12::
	;~ ExitApp
;~ return

;~;【获取屏幕的分辨率】
BG_GetDPI(){
	SysGet, Mon, Monitor
	ratio := MonRight/MonBottom
	if (MonRight = 1920 && MonBottom = 1080)
		return "1920x1080"
	else if (MonRight = 1600 && MonBottom = 900)
		return "1600x900"
	else if (ratio = 16/10)
		return "1920x1200"
	else if (ratio = 4/3)
		return "1024x768"
	else if (MonRight = 1366 && MonBottom = 768)
		return "1366x768"
	else
		return "1920x1080"
}