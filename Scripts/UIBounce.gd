extends TextureButton

@export var layer: int = 0

var tween : Tween  # Reference to the Tween node
var tweening : bool = true
@export var start_scale : Vector2 = Vector2(1.0,1.0)
@export var end_scale : Vector2 = Vector2(1.0,1.0)

# Called for GUI input events (like mouse clicks)
func _gui_input(event: InputEvent):
	if !disabled:
		if event is InputEventMouseButton && event.pressed:
			tween = get_tree().create_tween()
			tween.tween_property(self, "scale", end_scale, 0.5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
			tweening = false
		else:
			if tweening == false && scale != start_scale:
				#if tween != null:
					#tween.stop()
				tweening = true
				tween = get_tree().create_tween()
				tween.tween_property(self, "scale", start_scale, 0.25).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
				await tween.finished
				
				if event is InputEventMouseButton && event.is_released():
					if name == "ExitButton":
						get_tree().quit()
					elif name == "ShplapLogo":
						OS.shell_open("https://github.com/Shplap")
					elif name == "PlayButton":
						disabled = true
						
						get_node("/root/MainMenu/AudioStreamPlayer").playing = false
						get_node("PlaySound01").playing = true
						
						LoadLevel.change_scene(get_node("PlaySound01").finished)
					
				tweening = false
