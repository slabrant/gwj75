extends TextureButton

@onready var world: Node = get_tree().root.get_child(0).find_child("World")
const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	return


func _on_pressed() -> void:
	world.allow_input(false)
	var pause_menu = PAUSE_MENU.instantiate()
	#pause_menu.global_position = Vector2(-pause_menu.size.x/2, pause_menu.size.y/2)
	add_sibling(pause_menu)
