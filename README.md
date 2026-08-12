Windows 3.5mm Audio Hiss Fix
A simple workaround for a Windows audio issue where a 3.5mm headphone/IEM output produces a hiss when no audio is playing.
How it works
The hiss disappears when an audio stream is active.
This setup uses FFplay to continuously play digital silence:
```text
anullsrc → FFplay → Windows audio device
```
Because the audio device stays active, the 3.5mm output does not enter the idle state that causes the hiss.
Installation
1. Install FFmpeg
Open Command Prompt or PowerShell and run:
```cmd
winget install Gyan.FFmpeg.Shared
```
After installation, close and reopen the terminal.
Check that FFmpeg is installed:
```cmd
ffmpeg -version
```
Check that FFplay is installed:
```cmd
ffplay -version
```
You can also find the FFplay location with:
```cmd
where ffplay
```
2. Configure the VBS launcher
Open the `.vbs` file and make sure the `ffplay.exe` path matches the path returned by:
```cmd
where ffplay
```
Example:
```vbscript
Set WshShell = CreateObject("WScript.Shell")

WshShell.Run """C:\Users\daiki\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg.Shared_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0-full_build-shared\bin\ffplay.exe"" -f lavfi -i ""anullsrc=channel_layout=stereo:sample_rate=48000"" -nodisp -loglevel quiet", 0, False

Set WshShell = Nothing
```
3. Test the fix
Double-click the `.vbs` file.
If everything is working:
No CMD window should appear.
`ffplay.exe` should run in the background.
The 3.5mm hiss should disappear.
4. Start automatically with Windows
Press:
```text
Win + R
```
Enter:
```text
shell:startup
```
Create a shortcut to the `.vbs` file and place the shortcut in the Startup folder.
The hiss fix will then start automatically whenever you log into Windows.
Files
`ground loopfix.bat`
Optional manual launcher:
```bat
@echo off
ffplay -f lavfi -i "anullsrc=channel_layout=stereo:sample_rate=48000" -nodisp -loglevel quiet
```
`ground loopfix.vbs`
Recommended launcher. It starts FFplay without showing a CMD window:
```vbscript
Set WshShell = CreateObject("WScript.Shell")

WshShell.Run """C:\Users\daiki\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg.Shared_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0-full_build-shared\bin\ffplay.exe"" -f lavfi -i ""anullsrc=channel_layout=stereo:sample_rate=48000"" -nodisp -loglevel quiet", 0, False

Set WshShell = Nothing
```
Automatic startup
Press `Win + R`.
Enter:
```text
shell:startup
```
Create a shortcut to the `.vbs` file.
Put the shortcut inside the Startup folder.
Restart Windows.
FFplay will then start automatically after logging in.
Stop the fix
Open Task Manager → Details.
Find:
```text
ffplay.exe
```
Then choose End task.
Requirements
Windows
FFmpeg with `ffplay`
A 3.5mm audio output affected by idle-state hiss
Check FFplay with:
```cmd
ffplay -version
```
Find its location with:
```cmd
where ffplay
```
Important
This is a software workaround, not a physical ground-loop repair.
In this case, the fact that the hiss disappears when an audio stream is playing suggests that the noise is related to the Windows audio device's idle behavior, gain, or power management.
Linux/PipeWire may handle the same audio hardware differently, which explains why the hiss can disappear after logging into Linux.
Troubleshooting
CMD window appears
Do not launch the `.bat` from Startup.
Use the `.vbs` launcher instead.
The VBS launcher starts FFplay with its window hidden.
FFplay does not start
Run:
```cmd
where ffplay
```
If the path has changed, update the path inside the VBS file.
Hiss returns
Check Task Manager and make sure `ffplay.exe` is still running.
You can also manually test:
```cmd
ffplay -f lavfi -i "anullsrc=channel_layout=stereo:sample_rate=48000" -nodisp -loglevel quiet
```
If the hiss disappears while this is running, the workaround is working.
