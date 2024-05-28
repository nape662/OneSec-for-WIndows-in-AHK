# AutoHotkey Application Cooldown Script

This AutoHotkey script helps you manage your time by enforcing a cooldown period before you can relaunch specific applications. When you try to open a monitored application, it will prompt you to specify your intention and the allowed time duration before allowing the application to launch.

## Features
- Monitors specified applications and prevents them from launching without setting an intention and cooldown period.
- Displays a full-screen black window for a specified duration when an application is closed by the script.
- Logs user intentions and cooldown periods to a specified log file.
- Automatically closes the application and re-runs the black screen and intention logs after the specified cooldown period.

## Requirements
- AutoHotkey v2.0 or higher

## Setup Instructions

1. **Install AutoHotkey:**
   - Download and install AutoHotkey from [AutoHotkey's official website](https://www.autohotkey.com/).

2. **Script Configuration:**
   - *(Recommended)*: include this into your AHK script for everyday usage, where your regular shortcuts are stored.
   - Modify the `application_names` array to include the executable names of the applications you want to monitor and ahk_exe before them.
   - Modify the `application_paths` array to include the full paths to the executables or shortcuts of the applications.
   - Update the `LogFilePath` to the desired location for storing the intentions log file or comment out 2 lines that use the variable.

3. **Running the Script:**
   - Double-click the script file to run it.
   - The script will start monitoring the specified applications.

## Script Details

### Global Variables

- `black_screen_message`: The message displayed on the black screen.
- `black_screen_active`: Boolean indicating if the black screen is active.
- `black_screen_length`: Duration (in milliseconds) for the black screen to be displayed.
- `max_cooldown`: Maximum allowed cooldown period (in seconds).
- `application_names`: Array of application executable names to monitor.
- `application_paths`: Array of full paths to the application executables or shortcuts.
- `LogFilePath`: Path to the log file for storing user intentions.
- `cooldowns`: Array storing the cooldown periods for each application.

### Functions

- `CheckForGames()`: Checks if any monitored application is running and handles the cooldown logic.
- `ShowBlackScreen()`: Displays a full-screen black window with a message for a specified duration.
- `UserGoalAndTime(gameIndex)`: Prompts the user to enter their intention and cooldown period, and logs the information.
- `EnterInteger()`: Prompts the user to enter the number of minutes the application should stay open and validates the input.

### Hotkeys and HotIf Definitions

- `#HotIf black_screen_active`: Disables the Windows key when the black screen is active.
