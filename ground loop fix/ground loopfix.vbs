Set WshShell = CreateObject("WScript.Shell")

WshShell.Run """C:\Users\daiki\AppData\Local\Microsoft\WinGet\Packages\Gyan.FFmpeg.Shared_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-9.0-full_build-shared\bin\ffplay.exe"" -f lavfi -i ""anullsrc=channel_layout=stereo:sample_rate=48000"" -nodisp -loglevel quiet", 0, False

Set WshShell = Nothing