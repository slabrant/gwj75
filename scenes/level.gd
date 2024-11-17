extends Node2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var mirror_container: Node = $Mirrors
@onready var goal_container: Node = $Goals
@onready var build_mode_bg: TileMapLayer = $BuildModeBG
@onready var mirror_block: ColorRect = $MirrorBlock
@onready var build_mode_button: TextureButton = $BuildModeButton
const HAMMER_SPRITE = preload("res://sprites/hammer.png")
const HAMMER_PRESSED_SPRITE = preload("res://sprites/hammer_pressed.png")
const WIN_MENU = preload("res://scenes/menus/win_menu.tscn")

@export var is_build_mode : bool = false:
	set(value):
		if !build_mode_bg or !mirror_block:
			return
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
@export var goals : Array = []
@export var active_mirror : Area2D
@export var open_menu : Control:
	set(value):
		if !world:
			return
		world.toggle_input(!value)
		open_menu = value
@export var shot_count : int = 0
@export var mirror_count : int = 0


func _ready() -> void:
	for mirror in mirror_container.get_children():
		mirrors.append(mirror)
	#for goal in goal_container.get_children():
		#goals.append(goal)


func _process(delta: float) -> void:
	if Input.is_action_just_released("input_action"):
		active_mirror = null
	elif active_mirror:
		active_mirror.position = get_global_mouse_position()


func win() -> void:
	var menu = WIN_MENU.instantiate()
	get_tree().root.add_child(menu)


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
	for mirror in mirrors:
		mirror.build_mode_checks()
