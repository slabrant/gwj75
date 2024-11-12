extends TextureButton

const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	return
	print(event.position)


func _on_pressed() -> void:
	var pause_menu = PAUSE_MENU.instantiate()
	#var window_size = get_viewport().size
	#pause_menu.position = Vector2(window_size.x/2, window_size.y/2)
	pause_menu.global_position = Vector2(320, 180)
	get_tree().root.add_child(pause_menu)
	print(pause_menu.get_parent())
	#get_parent().add_sibling(pause_menu)
