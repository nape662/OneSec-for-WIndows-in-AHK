#Requires AutoHotkey v2.0

; --- Global Variables ---
black_screen_message := "sad black screen :bweheline:"
black_screen_active := false
cooldown := 0
black_screen_length := 2000  ; Length of the black screen in milliseconds (10 seconds)
game_exe := "ahk_exe Celeste.exe"
max_cooldown := 15 * 60  ; Cooldown length in seconds (15 minutes)
FilePath := "Your/Path/To/log.txt"

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
	global black_screen_message
    black_screen_active := true
	
	Gui_2 := Gui("AlwaysOnTop", "Fullscreen Black Window")
    Gui_2.Opt("+AlwaysOnTop -Caption +Disabled +Owner")
    Gui_2.BackColor := "Black"
    Gui_2.SetFont("s40", "Times New Roman")
    Gui_2.Show("x0 y0 w1920 h1080 NoActivate")
	
	DllCall("ShowCursor", "Int", false)
    MyGui := Gui("AlwaysOnTop", "Fullscreen Black Window")
    MyGui.Opt("+AlwaysOnTop -Caption +Disabled +Owner")
    MyGui.BackColor := "Black"
    MyGui.SetFont("s40", "Times New Roman")
    TempText := MyGui.AddText("cWhite", black_screen_message)
    TempText.SetFont("s40", "Times New Roman")
    MyGui.Show("AutoSize NoActivate")
	

    Sleep(black_screen_length)
    MyGui.Destroy()
	Gui_2.Destroy()
    black_screen_active := false
    DllCall("ShowCursor", "Int", true)
}


UserGoalAndTime() {
    global cooldown
    global max_cooldown
    global FilePath
    UserGoal := InputBox("Please tell me, what do you actually want from launching this?", "What is it that you want here huh??", "w300 h200")
    Sleep(2000)
    if (UserGoal != "" && UserGoal != "nothing" && UserGoal != "nothin") {
        TimeString := FormatTime(A_Now, "dd.MM.yyyy HH:mm")
		MinutesEntered := EnterInteger()
        cooldown := Min(MinutesEntered * 60, max_cooldown)
		FileAppend(UserGoal.Value " - " MinutesEntered " minutes entered at " TimeString "`n", FilePath)
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
