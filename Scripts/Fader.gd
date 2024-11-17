extends TextureRect

var fade_tween : Tween

func _ready():
	size = get_viewport().size
	
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(self, "modulate", Color(0,0,0,0), 0.25)
	
	await fade_tween.finished
	get_parent().get_node("AudioStreamPlayer").playing = true
	get_parent().get_node("Player").start_game()
