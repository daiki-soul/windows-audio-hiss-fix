@echo off
start "" /min ffplay -f lavfi -i "anullsrc=channel_layout=stereo:sample_rate=48000" -nodisp -loglevel quiet