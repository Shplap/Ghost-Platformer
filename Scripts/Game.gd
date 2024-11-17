extends Node2D

# Set up a variable for the window size with the value as the default resolution. 
var window_size = Vector2i(1280, 720)

func _process(_delta):
	# check to see if the window size changes
	if DisplayServer.window_get_size() != window_size:
		# Get the current window width
		var window_w = DisplayServer.window_get_size().x
		# Since the resolution is 16:9; to get the height, divide the width by 16 and multiply by 9
		# Or you can set the resolution width and height as variables, to suit other resolutions.
		var window_h = window_w / 16.0 * 9.0
		# Set the window size to the current width and the new height
		DisplayServer.window_set_size(Vector2i(ceil(window_w), ceil(window_h)))
		# Change the window_size variable to match the new size
		window_size = DisplayServer.window_get_size()
