shader_type canvas_item;
// #267DFF
// #0066FF

uniform float scroll_speed;
uniform vec4 color : source_color = vec4(1.0);
uniform float offset = 0.0;
uniform float width = 0.0;

void fragment() {
    vec2 u = UV;
    u.x += scroll_speed * TIME * width - offset;
    vec4 col = texture(TEXTURE, u);
    col *= color;
    COLOR = col;
}