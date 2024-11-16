extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")

const MIRROR = preload("res://scenes/objects/mirrors/mirror_normal.tscn")

@export var is_moving : bool = false


func _on_touch_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if level.is_build_mode and event.has_method("is_action_pressed") and event.is_action_pressed("input_action") and not level.active_mirror:
		var mirror : Area2D = MIRROR.instantiate()
		mirror.position = get_global_mouse_position()
		level.active_mirror = mirror
		mirror.locked = false
		level.mirrors.append(mirror)
		level.find_child("Mirrors").add_child(mirror)
		mirror.build_mode_checks()
