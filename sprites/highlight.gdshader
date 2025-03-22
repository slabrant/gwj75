shader_type canvas_item;

uniform float percent = 1.0;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 original_color = texture(TEXTURE, UV);

	vec4 new_color = original_color * percent;

	COLOR = new_color;
}