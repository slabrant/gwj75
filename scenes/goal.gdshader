shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);

	vec4 new_color = original_color;
	if (active == true) {
		float new_gray = (original_color.r + original_color.g + original_color.b)/3.0;
		new_color = vec4(new_gray, new_gray, new_gray, original_color.a);
	}

	COLOR = new_color;
}