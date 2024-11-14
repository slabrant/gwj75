extends Node

@onready var mirror_scenes: Node = $Mirrors
@onready var build_mode_bg: TileMapLayer = $BuildModeBG

@onready var build_mode_button: CheckButton = $BuildModeButton

@export var is_build_mode : bool = false:
	set(value):
		build_mode_bg.hide()
		if value:
			build_mode_bg.show()
		is_build_mode = value
@export var mirrors : Array = []
@export var open_menu : Control:
	set(value):
		toggle_input(!value)
		open_menu = value
@export var shot_count : int = 0
@export var mirror_count : int = 0


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
