extends RigidBody2D

# References to the visual nodes
var cube = null
var cube2 = null
var cube_glow = null

# References to the particle systems
var ground_particles = null
var ground_particles2 = null

# Movement variables
var jump_force = -1000  # Adjust this for higher or lower jumps
var rotation_speed = 360  # Speed of rotation during the jump (degrees per second)
var is_jumping = false
var rotation_target = 0 # First jump will rotate to 180 degrees
var current_rotation = 0  # Initial rotation is 0

# RayCast2D to detect ground
var ground_ray = null

var g_shader_material : ShaderMaterial
var bg_shader_material : ShaderMaterial

var time : float = 0.0

func start_game():
	#position.x = 393
	self.linear_velocity = Vector2(463, 0)
	
	while position.x < 393:
		await get_tree().process_frame
	self.linear_velocity = Vector2(0, 0)
	
	# Offset the G and BG so they don't start in the wrong place (TODO)
	g_shader_material.set_shader_parameter("offset", Time.get_ticks_msec()-time)
	g_shader_material.set_shader_parameter("scroll_speed", 3.0)
	bg_shader_material.set_shader_parameter("offset", Time.get_ticks_msec()-time)
	bg_shader_material.set_shader_parameter("scroll_speed", 0.05)
	
	position.x = 393

func _ready():
	time = Time.get_ticks_msec()
	
	g_shader_material = get_parent().get_node("G1").get_node("ScrollingG").material as ShaderMaterial
	g_shader_material.set_shader_parameter("scroll_speed", 0.0)
	g_shader_material.set_shader_parameter("color", Vector4(0, 0.4, 1, 1))
	
	bg_shader_material = get_parent().get_node("BG1").get_node("ScrollingBG").material as ShaderMaterial
	bg_shader_material.set_shader_parameter("scroll_speed", 0.0)
	bg_shader_material.set_shader_parameter("color", Vector4(0.149, 0.4902, 1, 1))
	
	position.x = -70
	
	# Initialize player rotation and particle states
	cube = get_node("Cube")
	cube2 = get_node("Cube2")
	cube_glow = get_node("CubeGlow")
	ground_particles = get_node("GroundParticles")
	ground_particles2 = get_node("GroundParticles2")
	ground_ray = get_node("GroundRaycast")

	cube.rotation_degrees = 0
	cube2.rotation_degrees = 0
	cube_glow.rotation_degrees = 0
	ground_particles.emitting = true
	ground_particles2.emitting = true

	# Reset physics-related properties to ensure no unwanted forces
	self.linear_velocity = Vector2.ZERO  # Ensure there is no initial velocity

func _physics_process(_delta):
	# Check for ground and jump input
	var is_on_ground = position.y >= 404.6

	# Start jump if on the ground and input is pressed
	if Input.is_action_pressed("jump") and is_on_ground and !is_jumping:
		jump()
	ground_particles.position.y = -(position.y - 405 - 54.5);
	ground_particles2.position.y = -(position.y - 405 - 54.5);
	
	# If the player has landed and rotation is complete, reset the jump
	if is_on_ground and is_jumping and abs(current_rotation - rotation_target) < 1:
		reset_jump()

func jump():
	# Apply jump force purely vertically
	self.linear_velocity.y = jump_force  # Set vertical velocity (no horizontal force applied)

	# Set jumping flag
	is_jumping = true

	# Stop emitting particles when jumping
	ground_particles.emitting = false
	ground_particles2.emitting = false

	if rotation_target == 0:
		rotation_target = 180
	elif rotation_target == 180:
		rotation_target = 360  # After the first jump, set target to 360
	# After the second jump, set rotation target back to 0
	elif rotation_target == 360:
		current_rotation = 0
		rotation_target = 180  # After the second jump, reset target to 180

func reset_jump():
	if current_rotation == 360:
		current_rotation = 0
		cube.rotation_degrees = current_rotation
		cube2.rotation_degrees = current_rotation
		cube_glow.rotation_degrees = current_rotation
	
	# Stop emitting particles when landing
	ground_particles.emitting = true
	ground_particles2.emitting = true

	## Set current_rotation to match the target rotation after landing
	current_rotation = rotation_target

	# Allow jumping again by resetting the is_jumping flag
	is_jumping = false

func _process(delta):
	# Rotate cube smoothly while jumping
	if is_jumping:
		rotate_cube(delta)
	
	# Stop the player clipping the ground
	if position.y > 404.6492:
		cube.position.y = -(position.y - 404.6492)
		cube2.position.y = -(position.y - 404.6492) + 11
		cube_glow.position.y = -(position.y - 404.6492) - 2.5
	else:
		cube.position.y = 0
		cube2.position.y = 11
		cube_glow.position.y = -2.5

func rotate_cube(delta):
	# Gradually rotate cube towards the target rotation
	if current_rotation != rotation_target:
		var rotation_step = rotation_speed * delta
		# Increment rotation only in the forward direction
		
		if current_rotation < rotation_target:
			current_rotation += rotation_step
			if current_rotation > rotation_target:
				current_rotation = rotation_target
		
		# Apply the smooth rotation to the cube
		cube.rotation_degrees = current_rotation
		cube2.rotation_degrees = current_rotation
		cube_glow.rotation_degrees = current_rotation
