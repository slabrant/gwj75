extends Node

@onready var mirror_scenes: Node = $Mirrors
@onready var tile_map_bg: TileMapLayer = $TileMapBG

@onready var build_mode_button: CheckButton = $BuildModeButton

@export var is_build_mode : bool = false:
	set(value):
		tile_map_bg.hide()
		if value:
			tile_map_bg.show()
		is_build_mode = value
@export var mirrors : Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mirror in mirror_scenes.get_children():
		mirrors.append(mirror)


func toggle_input(enable: bool):
	disable_input_recursive(get_tree().root, enable)


func disable_input_recursive(node: Node, enable):
	node.set_process(enable)
	node.set_physics_process(enable)
	for child in node.get_children():
		disable_input_recursive(child, enable)


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
	for mirror in mirrors:
		mirror.build_mode_checks()
