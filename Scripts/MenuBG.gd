extends Node2D

# Initial color
@onready var texture = $ScrollingBG
var shader_material : ShaderMaterial
var rgb : Vector4 = Vector4(0.149, 0.4902, 1, 1)
var time_passed : float = 0.0  # Tracks elapsed time
var cycle_speed : float = -0.1  # Speed of the color cycle

func _process(delta):
	# Increment elapsed time
	time_passed += delta * cycle_speed

	# Update RGB values using sine wave
	rgb.x = abs(sin(time_passed))  # Red channel
	rgb.y = abs(sin(time_passed + PI / 3))  # Green channel
	rgb.z = abs(sin(time_passed + 2 * PI / 3))  # Blue channel
	rgb.w = 1.0  # Alpha remains constant

	shader_material = texture.material as ShaderMaterial
	shader_material.set_shader_parameter("color", rgb)
