extends Node

@onready var world: Node = get_tree().root.get_child(0)
@onready var mirror_scenes: Node = $Mirrors
@onready var build_mode_bg: TileMapLayer = $BuildModeBG
@onready var mirror_block: ColorRect = $MirrorBlock
@onready var build_mode_button: TextureButton = $BuildModeButton
const HAMMER_SPRITE = preload("res://sprites/hammer.png")
const HAMMER_PRESSED_SPRITE = preload("res://sprites/hammer_pressed.png")

@export var is_build_mode : bool = false:
	set(value):
		if value:
			build_mode_bg.show()
			mirror_block.hide()
			build_mode_button.texture_normal = HAMMER_PRESSED_SPRITE
			build_mode_button.texture_pressed = HAMMER_SPRITE
		else:
			build_mode_bg.hide()
			mirror_block.show()
			build_mode_button.texture_normal = HAMMER_SPRITE
			build_mode_button.texture_pressed = HAMMER_PRESSED_SPRITE
		
		is_build_mode = value
@export var mirrors : Array = []
@export var open_menu : Control:
	set(value):
		world.toggle_input(!value)
		open_menu = value
@export var shot_count : int = 0
@export var mirror_count : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for mirror in mirror_scenes.get_children():
		mirrors.append(mirror)


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
	for mirror in mirrors:
		mirror.build_mode_checks()
