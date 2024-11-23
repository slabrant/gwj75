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
@export var goals : Array = []:
	set(value):
		if 0 < len(goals) and len(value) < 1:
			win()
		goals = value
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
	var new_goals = []
	for goal in goal_container.get_children():
		new_goals.append(goal)
	goals = new_goals


func _process(delta: float) -> void:
	if Input.is_action_just_released("input_action"):
		active_mirror = null
	elif active_mirror:
		active_mirror.position = get_global_mouse_position()


func win() -> void:
	if shot_count <= 8 and mirror_count <= 2:
		world.level_score = 3
	elif shot_count <= 15 and mirror_count <= 5:
		world.level_score = 2
	else:
		world.level_score = 1
	
	if open_menu:
		open_menu.close()
	else:
		var menu = WIN_MENU.instantiate()
		get_tree().root.add_child(menu)


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
	for mirror in mirrors:
		mirror.build_mode_checks()
