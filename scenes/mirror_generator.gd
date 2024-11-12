extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var world: Node = get_tree().root.get_child(0).find_child("World")

const MIRROR = preload("res://scenes/mirror.tscn")

@export var is_moving : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_released("input_action"):
		#is_moving = false
	#if is_moving:
		#position = get_global_mouse_position()


func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if world.is_build_mode and event.has_method("is_action_pressed") and event.is_action_pressed("input_action"):
		var mirror : Area2D = MIRROR.instantiate()
		mirror.position = get_global_mouse_position()
		mirror.is_moving = true
		mirror.locked = false
		world.mirrors.append(mirror)
		world.find_child("Mirrors").add_child(mirror)
		mirror.build_mode_checks()
