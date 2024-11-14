shader_type canvas_item;
// #267DFF
// #0066FF

uniform float scroll_speed;
uniform vec4 color : source_color = vec4(1.0);

void fragment() {
    vec2 u = UV;
    u.x += scroll_speed * TIME;
    vec4 col = texture(TEXTURE, u);
    col *= color;
    COLOR = col;
}