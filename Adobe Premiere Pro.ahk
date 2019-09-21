#NoEnv
SetWorkingDir %A_ScriptDir%

;-----------Functions------------;

;---Checks if Editing 2 panel tab is selected, if not, gives you a warning---;
checkpanel() 
{
	ImageSearch, effx, effy,1 ,1 ,2560 ,300 ,  %A_WorkingDir%\Assets\img_editing2_active.png
	if ErrorLevel = 1 
    {
		MsgBox Wrong Workspace
		Exit
	}
}
	

;--------Checks if Effects panel is selected, if not, it selects it, then checks if "Favourite Effects" tab is expanded, if not, it expands it---;
checke() 
{
	CoordMode, Mouse [, Screen]
	ImageSearch, effx, effy,1 ,1 ,2560 ,300 ,  %A_WorkingDir%\Assets\img_effects_active.png
	if (ErrorLevel = 2) 
    {
		MsgBox Error
		Exit
	} else if (ErrorLevel = 1) 
    {
		ImageSearch, ieffx, ieffy,1 ,1 ,2560 ,300 ,  %A_WorkingDir%\Assets\img_effects_inactive.png
		MouseGetPos, startx, starty
		sleep, 10
		MouseClick, left, ieffx ,ieffy
		sleep, 100
		MouseMove, startx, starty
	}
	ImageSearch, effx, effy,1 ,1 ,2560 ,800 ,  %A_WorkingDir%\Assets\img_faveffectstab_expanded.png
	if ErrorLevel = 2 
    {
		MsgBox Failed
		Exit
	} 
    else if ErrorLevel = 1 
    {
		ImageSearch, tabx, taby,1 ,1 ,2560 ,800 ,  %A_WorkingDir%\Assets\img_faveffectstab_collapsed.png
		MouseGetPos, startx, starty
		sleep, 10
		MouseClick, left, tabx ,taby
		sleep, 100
		MouseMove, startx, starty
	}
}

;-------Ckecks if Effect Controls panel is selected, if not, selects it---;
checkcontrols() 
{
	CoordMode, Mouse [, Screen]
	ImageSearch, ieffcx, ieffcy,1 ,1 ,2560 ,1000 ,  %A_WorkingDir%\Assets\img_effectcontrols_active.png 
	if ErrorLevel = 2 
    {
		MsgBox Failed
		Exit
	} 
    else if ErrorLevel = 1 
    {
		ImageSearch, ieffcx, ieffcy,1 ,1 ,2560 ,1000 ,  %A_WorkingDir%\Assets\img_effectcontrols_inactive.png
		MouseGetPos, startx, starty
		sleep, 10
		MouseClick, left, ieffcx ,ieffcy
		sleep, 100
		MouseMove, startx, starty
	}
}

	;----------Functions End------------;


;--------------------SCRIPTS------------------------;

	;----Warp Stabilizer----;
#IfWinActive Adobe Premiere Pro
<^w::
checkpanel()
CoordMode, Mouse [, Screen]
BlockInput, SendAndMouse
SetKeyDelay, 1
MouseGetPos, intx, inty
MouseClick, left
sleep, 10
checke()
checkcontrols()
ImageSearch, warpx, warpy,1 ,1 ,2560 ,1000 , %A_WorkingDir%\Assets\img_warpstabilizer.png
	if ErrorLevel = 1
		ImageSearch, warpx, warpy,1 ,1 ,2560 ,1000 , %A_WorkingDir%\Assets\img_warpstabilizer_selected.png
MouseMove, warpx, warpy
MouseClickDrag, Left, , ,intx, inty
sleep, 20
MouseClick, left
sleep, 10
checkcontrols()
ImageSearch, smoothx, smoothy, 1, 1, 2560, 1440, %A_WorkingDir%\Assets\img_smoothness.png
if ErrorLevel = 1
{
	MsgBox Error
	Exit
}
smoothx += 13
smoothy += 30
MouseClick, left, smoothx, smoothy,
sleep, 10
Send {5}
sleep, 10
Send {Enter}
ImageSearch, analx, analy, 1, 1, 2560, 800, %A_WorkingDir%\Assets\img_analyze.png
analx += 40
analy += 5
MouseClick, left, analx, analy,
sleep, 10
MouseMove, intx, inty
BlockInput, off
return

	;----Warp Stabilizer with nest----;
#IfWinActive Adobe Premiere Pro
<^<!w::
BlockInput, SendAndMouse
BlockInput, on
CoordMode, Mouse [, Screen]
SetKeyDelay, 1
MouseGetPos, intx, inty
MouseClick, left
sleep, 10
Send {Blind}^!b
sleep, 50
SendInput {Enter}
sleep, 500
MouseClick, left
sleep, 10
checke()
checkcontrols()
ImageSearch, warpx, warpy,1 ,1 ,2560 ,1000 , %A_WorkingDir%\Assets\img_warpstabilizer.png
	if ErrorLevel = 1
		ImageSearch, warpx, warpy,1 ,1 ,2560 ,1000 , %A_WorkingDir%\Assets\img_warpstabilizer_selected.png
MouseMove, warpx, warpy
MouseClickDrag, Left, , ,intx, inty
sleep, 20
MouseClick, left
sleep, 10
checkcontrols()
ImageSearch, smoothx, smoothy, 1, 1, 2560, 1440, %A_WorkingDir%\Assets\img_smoothness.png
if ErrorLevel = 1
{
	MsgBox Error
	Exit
}
smoothx += 13
smoothy += 30
MouseClick, left, smoothx, smoothy,
sleep, 10
Send {5}
sleep, 10
Send {Enter}
ImageSearch, analx, analy, 1, 1, 2560, 800, %A_WorkingDir%\Assets\img_analyze.png
analx += 40
analy += 5
MouseClick, left, analx, analy,
sleep, 10
MouseMove, intx, inty
BlockInput, off
return

	;----50% scale----;
#IfWinActive Adobe Premiere Pro
<^e::
BlockInput, SendAndMouse
BlockInput, on
CoordMode, Mouse [, Screen]
SetKeyDelay, 1
MouseGetPos, intx, inty
MouseClick, left
sleep, 10
checkcontrols()
sleep, 100
ImageSearch, scalex, scaley, 1, 1, 2560, 800, %A_WorkingDir%\Assets\img_scale.png
MouseMove, scalex, scaley
sleep, 10
MouseClick, left
sleep, 10
Send {text}50
Send {Enter}
sleep, 10
MouseMove, intx, inty
BlockInput, off
return

	;----50% scale, nest, warp stabilizer----;
#IfWinActive Adobe Premiere Pro
<^<!e::
BlockInput, SendAndMouse
BlockInput, on
CoordMode, Mouse [, Screen]
SetKeyDelay, 1
MouseGetPos, intx, inty
MouseClick, left
sleep, 10
checkcontrols()
sleep, 100
ImageSearch, scalex, scaley, 1, 1, 2560, 800, %A_WorkingDir%\Assets\img_scale.png
MouseMove, scalex, scaley
sleep, 10
MouseClick, left
sleep, 10
Send {text}50
Send {Enter}
sleep, 10
MouseMove, intx, inty
sleep, 10
MouseClick, left
sleep, 10
checkcontrols()
Send {Blind}^!b
sleep, 50
SendInput {Enter}
sleep, 500
MouseClick, left
sleep, 10
checke()
checkcontrols()
ImageSearch, warpx, warpy,1 ,1 ,2560 ,1000 , %A_WorkingDir%\Assets\img_warpstabilizer.png
	if ErrorLevel = 1
		ImageSearch, warpx, warpy,1 ,1 ,2560 ,1000 , %A_WorkingDir%\Assets\img_warpstabilizer_selected.png
MouseMove, warpx, warpy
MouseClickDrag, Left, , ,intx, inty
sleep, 20
MouseClick, left
sleep, 10
checkcontrols()
ImageSearch, smoothx, smoothy, 1, 1, 2560, 1440, %A_WorkingDir%\Assets\img_smoothness.png
if ErrorLevel = 1 
{
	MsgBox Error
	Exit
}
smoothx += 13
smoothy += 30
MouseClick, left, smoothx, smoothy,
sleep, 10
Send {5}
sleep, 10
Send {Enter}
ImageSearch, analx, analy, 1, 1, 2560, 800, %A_WorkingDir%\Assets\img_analyze.png
if ErrorLevel = 1
	{
	MouseMove, intx, inty
	return
	}
analx += 40
analy += 5
MouseClick, left, analx, analy,
sleep, 10
MouseMove, intx, inty
BlockInput, off
return
