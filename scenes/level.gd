extends Node2D

@onready var world: Node = get_tree().root.get_child(0)
@onready var mirror_container: Node = $Mirrors
@onready var goal_container: Node = $Goals
@onready var build_mode_bg: TileMapLayer = $BuildModeBG
@onready var mirror_block: ColorRect = $MirrorBlock
@onready var build_mode_button: TextureButton = $BuildModeButton
@onready var camera_2d: Camera2D = $Camera2D
@onready var level_number: Label = $LevelNumber
@onready var placeable_area: TileMapLayer = $PlaceableArea

const HAMMER_SPRITE = preload("res://sprites/hammer.png")
const HAMMER_PRESSED_SPRITE = preload("res://sprites/hammer_pressed.png")
const WIN_MENU = preload("res://scenes/menus/win_menu.tscn")
const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")

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

@export var flying_beams: Array = []
@export var mirrors : Array = []
@export var goals : Array = []:
	set(value):
		if len(value) < 1:
			win()
		goals = value
@export var cleared_goals : Array = []
@export var active_mirror : StaticBody2D
@export var selected_mirror : StaticBody2D
@export var open_menu : Control:
	set(value):
		if !world:
			return
		world.toggle_input(!value)
		open_menu = value
@export var shot_count : int = 0
@export var mirror_count : int = 0
@export var shot_par : int = 8
@export var mirror_par : int = 2
@export var camera : Camera2D


func _ready() -> void:
	for mirror in mirror_container.get_children():
		mirrors.append(mirror)
	var new_goals = []
	for goal in goal_container.get_children():
		new_goals.append(goal)
	goals = new_goals
	camera = camera_2d
	
	var level_id_string = str(world.level_id)
	level_number.text = "00".left(2 - len(level_id_string)) + level_id_string


func _process(delta: float) -> void:
	if Input.is_action_just_released("input_action"):
		if active_mirror:
			if !placeable_area.get_cell_tile_data(placeable_area.local_to_map(active_mirror.position)):
				active_mirror.remove()
			var buttons_extreme = active_mirror.buttons.global_position + active_mirror.buttons.position.normalized() * Vector2(6,0)
			if !placeable_area.get_cell_tile_data(placeable_area.local_to_map(buttons_extreme)):
				active_mirror.buttons.position.x *= -1
			selected_mirror = active_mirror
			selected_mirror.is_selected = true
			active_mirror = null
	elif active_mirror:
		var new_position = get_global_mouse_position() + active_mirror.click_offset
		if world.position_snapping_setting:
			new_position = round(new_position / 4) * 4
		active_mirror.position = new_position


func win() -> void:
	if shot_count <= shot_par and mirror_count <= mirror_par:
		world.level_score = 3
	elif shot_count <= shot_par * 2 + 1 and mirror_count <= mirror_par * 2 + 1:
		world.level_score = 2
	else:
		world.level_score = 1
	
	if open_menu:
		open_menu.close()
	var menu = WIN_MENU.instantiate()
	get_tree().root.add_child(menu)


func remove_goal(goal):
	var level_goals : Array = goals.duplicate()
	level_goals.erase(goal)
	goals = level_goals
	cleared_goals.append(goal)


func _on_menu_button_pressed() -> void:
	if open_menu:
		open_menu.close()
	else:
		var menu = PAUSE_MENU.instantiate()
		get_tree().root.add_child(menu)


func _on_build_mode_button_pressed() -> void:
	is_build_mode = !is_build_mode
	for mirror in mirrors:
		mirror.build_mode_checks()
	for goal in cleared_goals:
		goal.unwin()
	for beam in flying_beams:
		beam.queue_free()
	flying_beams = []
	cleared_goals = []
