extends TextureRect

var shader_material : ShaderMaterial

func _ready():
	# Make sure the material is a ShaderMaterial
	shader_material = material as ShaderMaterial

	if shader_material:
		# Set the texture for the game sheet
		shader_material.set_shader_param("game_sheet", preload("res://Assets definitely not taken from GD/GJ_GameSheet-uhd.png"))
		
		# Set the top-left corner of the region to crop (in pixels)
		shader_material.set_shader_param("texture_position", Vector2(100, 50))  # Example position
		
		# Set the size of the cropped region (in pixels)
		shader_material.set_shader_param("texture_size", Vector2(64, 64))  # Example size
		
		# Set the size of the full game sheet (in pixels)
		shader_material.set_shader_param("texture_sheet_size", Vector2(512, 512))  # Example full sheet size
