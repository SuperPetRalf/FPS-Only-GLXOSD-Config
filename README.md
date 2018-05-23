This configuration file provides a FPS (Frames Per Second) Counter only in the
top left of the screen using GLXOSD. Has most options turned off to only show
the frame count, and was designed for showing the FPS while playings games.

This requires GLXOSD to be installed on the system.

Place the glxosd_config.lua in the correct folder according to your system.
More can be found on this at: https://glxosd.nickguletskii.com/docs/config/
For most people $HOME/.config/glxosd should work. If the directory does not
exist then create the folder and the file.

Launch the game or application with the glxosd command e.g.
glxosd ./game.sh

This should give a FPS counter in the top left corner of the screen, on a 1080p
screen. On 4k screen, some tweaking is required. I suggest doubling the font size.
If you are using a 4k resolution on the WM, but running the application at 1080
then the FPS count might appear in the middle left of the screen.

The default counters are set to show as red (low frame rate) under 29 frames.

If you need to change the low fps count, font size or placement
then search and change the following values in the file:

For the font, find and change the following value:
font_size = 20

For the low FPS count:
low_fps = 29

Placement of the text:
align_to_h = "left"
align_to_v = "top"

There are a lot more values that can be the changed and configuration options,
this if only a basic file for people that want to play games showing  only the
FPS count.
