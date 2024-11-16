shader_type canvas_item;

uniform float color_mix : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec4 color : source_color = vec4(1.0);
uniform bool gradient = false;
uniform vec4 color2 : source_color = vec4(1.0);
uniform float brightness : hint_range(0.0, 5.0) = 1.0;
uniform float opacity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	col *= color;
	col *= brightness;
	
	if (gradient) {
		// Calculate the position of the gradient based on UV.x (or UV.y, depending on the direction of the gradient)
		float gradient_factor = abs(UV.y - 0.5) * 25.0; // Creates a gradient from color2 to color and back to color2
		
		// Interpolate between color2 and color based on the gradient factor
		vec4 gradient_color = mix(color, color2, gradient_factor);
		
		// Apply the gradient color on top of the texture color
		col *= gradient_color;
	}
	
	if (color_mix > 0.0) {
		float alpha = COLOR.a;
		COLOR = min(col+textureLod(screen_texture, SCREEN_UV, 0.0),1.0);
		COLOR.a = alpha - (1.0-opacity);
	} else {
		COLOR = col;
		COLOR.a -= (1.0-opacity);
	}
}