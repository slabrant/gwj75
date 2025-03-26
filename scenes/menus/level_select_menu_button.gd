extends TextureButton


func _ready() -> void:
	set_color(0.85)


func set_color(percent: float = 0.0):
	material.set("shader_param/percent", percent)


func _on_button_down() -> void:
	set_color(0.5)


func _on_button_up() -> void:
	set_color(0.95)


func _on_mouse_entered() -> void:
	set_color(0.95)


func _on_mouse_exited() -> void:
	set_color(0.85)
