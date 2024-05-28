

; --- Hotkeys and HotIf Definitions ---
#HotIf black_screen_active
LWin::Return
; --- Celeste script ---
SetTimer(CheckForGames, 1000)  

; --- Global Variables ---
black_screen_message := "sad black screen"
black_screen_active := false
black_screen_length := 10000  ; Length of the black screen in milliseconds (10 seconds)
max_cooldown := 15 * 60  ; Cooldown length in seconds (15 minutes)

application_names := ["ahk_exe Celeste.exe", "ahk_exe Discord.exe"]
application_paths := ["Your\Path\To\Celeste.exe", "And\Your\Shortcut\Or\Path\To\Discord.exe"] 
LogFilePath := "C:\Users\peter\OneDrive\Documents\AutoHotkey\Intentions log.txt"

cooldowns := []
Loop application_names.Length
    cooldowns.Push(0)


; --- Function Definitions ---
CheckForGames() {
    global cooldowns
    global application_names
    Loop application_names.Length {
        if (cooldowns[A_Index] > 0) {
            cooldowns[A_Index] -= 1
            continue
        }

        If WinExist(application_names[A_Index]) { 
            WinMoveBottom(application_names[A_Index])
            WinKill(application_names[A_Index]) 
            ShowBlackScreen()
            UserGoalAndTime(A_Index)
        }
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

UserGoalAndTime(gameIndex) {
    global cooldowns
    global max_cooldown
    global LogFilePath
    UserGoal := InputBox("Please tell me, what do you actually want from launching this?", "What is it that you want here huh??", "w300 h200")
    Sleep(2000)
    if (UserGoal.Value != "" && UserGoal.Value != "nothing" && UserGoal.Value != "nothin") {
        TimeString := FormatTime(A_Now, "dd.MM.yyyy HH:mm")
        MinutesEntered := EnterInteger()
        cooldowns[gameIndex] := Min(MinutesEntered * 60, max_cooldown)
        FileAppend(UserGoal.Value " - " MinutesEntered " minutes entered at " TimeString "`n", LogFilePath)
        if (cooldowns[gameIndex] > 0) {
            Run(application_paths[gameIndex])
        } else {
            MsgBox("GJ mate, bye!")
        }
    } else {
        MsgBox("GJ mate, bye!")
    }
}

EnterInteger() {
    EnteredValue := InputBox("How many minutes should the game stay open?", "Input Required", "w300 h200")
    try {
        cooldown := Integer(EnteredValue.Value)
        return cooldown
    } catch {
        return EnterInteger()
    }
}
