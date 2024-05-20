#Requires AutoHotkey v2.0

#HotIf black_screen_active
LWin::Return
; --- Celeste script ---
SetTimer(CheckForCeleste, 1000)  

; --- Global Variables ---
black_screen_active := false
cooldown := 0
black_screen_length := 10000  ; Length of the black screen in milliseconds (10 seconds)
game_exe := "ahk_exe Celeste.exe"
max_cooldown := 15 * 60  ; Cooldown length in seconds (15 minutes)
FilePath := "C:\Users\peter\OneDrive\Documents\AutoHotkey\Intentions log.txt"

; --- Function Definitions ---
CheckForCeleste() {
    global cooldown
    global game_exe
    if (cooldown > 0) {
        cooldown -= 1
        return
    }

    If WinExist(game_exe) { 
        WinMoveBottom(game_exe)
        WinKill(game_exe) 
        ShowBlackScreen()
        UserGoalAndTime()
    }
}

ShowBlackScreen() {
    global black_screen_active
    global black_screen_length
    black_screen_active := true

    DllCall("ShowCursor", "Int", false)
    MyGui := Gui("AlwaysOnTop", "Fullscreen Black Window")
    MyGui.Opt("+AlwaysOnTop -Caption +Disabled +Owner")
    MyGui.BackColor := "Black"
    MyGui.SetFont("s40", "Times New Roman")
    MyGui.Add("Text", "x600 y425 cWhite vMyText", "A smol pause from gaimin")
    MyGui.Show("x0 y0 w1920 h1080 NoActivate")
    Sleep(black_screen_length)
    MyGui.Destroy()
    black_screen_active := false
    DllCall("ShowCursor", "Int", true)
}

UserGoalAndTime() {
    global cooldown
    global max_cooldown
	global FilePath
    UserGoal := InputBox("Please tell me, what do you actually want from launching this?", "What is it that you want here huh??", "w300 h200")
    Sleep(2000)
    if (UserGoal.Value != "" and UserGoal.Value != "nothing" and UserGoal.Value != "nothin") {
        FileAppend(UserGoal.Value "`n", FilePath)
        cooldown := Min(EnterInteger() * 60, max_cooldown)
        if (cooldown > 0) {
            Run("C:\Program Files (x86)\Steam\steamapps\common\Celeste\Celeste.exe")
        } else {
            MsgBox("GJ mate, bye!")
        }
    } else {
        MsgBox("GJ mate, bye!")
    }
}

EnterInteger() {
    EnteredValue := InputBox("How many minutes should Celeste stay opened?", "Input Required", "w300 h200")
    try {
        cooldown := Integer(EnteredValue.Value)
        return cooldown
    } catch {
        return EnterInteger()
    }
}
