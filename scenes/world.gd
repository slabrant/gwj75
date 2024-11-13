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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
	for mirror in mirrors:
		mirror.build_mode_checks()
