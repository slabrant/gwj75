extends Node

@export var scene_path : String:
	set(value):
		scene = load(value).instantiate()
		scene_path = value
@export var scene : Node:
	set(value):
		if !!scene:
			scene.queue_free()
		scene = value
		add_child(value)


func _ready() -> void:
	scene_path = "res://scenes/menus/start_menu.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
