shader_type canvas_item;

uniform float red = 0.0;
uniform float green = 0.0;
uniform float blue = 0.0;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);

	vec4 new_color = original_color;
	new_color = vec4((original_color.r + red)/2.0, (original_color.g + green)/2.0, (original_color.b + blue)/2.0, original_color.a);

	COLOR = new_color;
}