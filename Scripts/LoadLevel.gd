extends Node2D

var fade_tween : Tween
var fade_box : TextureRect

func change_scene(wait_for):
	#await get_tree().create_timer(delay).timeout
	
	fade_box = TextureRect.new()
	fade_box.texture = load("res://Assets definitely not taken from GD/pixel-hd.png")
	fade_box.size = get_viewport().size
	fade_box.modulate = Color(0,0,0,0)
	fade_box.z_index = 999
	get_node("/root/MainMenu/").add_child(fade_box)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(fade_box, "modulate", Color.BLACK, 0.25)
	await wait_for
	
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
