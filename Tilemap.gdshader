shader_type canvas_item;

// Position and size of the crop area in pixels
uniform float start_x;
uniform float start_y;
uniform float width;
uniform float height;
uniform vec4 color : source_color = vec4(1.0);

// Texture size in pixels
uniform vec2 texture_size;

void fragment() {
    // Map fragment coordinates to the cropped area
    vec2 cropped_uv = vec2(
        start_x + UV.x * width,
        start_y + UV.y * height
    );

    // Convert cropped_uv back to normalized UVs for sampling
    vec2 sampled_uv = cropped_uv / texture_size;

    // Ensure the sampled UVs are within the texture bounds to prevent artifacts
    if (sampled_uv.x >= 0.0 && sampled_uv.x <= 1.0 && sampled_uv.y >= 0.0 && sampled_uv.y <= 1.0) {
		vec4 col = texture(TEXTURE, sampled_uv);
		col *= color;
		COLOR = col;
    } else {
        discard;
    }
}
