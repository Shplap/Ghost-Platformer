extends TextureRect
var shader_material : ShaderMaterial

# Called when the node enters the scene tree for the first time.
func _ready():
	shader_material = material as ShaderMaterial
	shader_material.set_shader_parameter("scroll_speed", 0.05)
