shader_type canvas_item;
render_mode blend_add;

uniform float red = 0.0;
uniform float green = 0.0;
uniform float blue = 0.0;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	vec4 new_color = original_color;
	new_color = vec4(red, green, blue, original_color.a);
	COLOR = vec4(red, green, blue, original_color.a);
}